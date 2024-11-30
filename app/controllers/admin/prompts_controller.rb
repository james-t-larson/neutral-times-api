module Admin
  class PromptsController < ApplicationController
    def index
      generic_render(data: Prompt.current)
    end

    def update
      param!(:text, String)

      Prompt.current.update_column(:text, params[:text])
      generic_render(message: "Prompt has been updated")
    end

    def versions
      generic_render(data: Prompt.current.versions)
    end

    def version
      param!(:id, Integer)

      generic_render(data: Prompt.current.versions.find(params[:id]))
    end

    def restore
      param!(:id, Integer)

      version = Prompt.current.versions.find(params[:id])
      restored_instance = version.reify(allowed_classes: [ Time ])

      generic_render(data: restored_instance.save!)
    end

    def diff
      param!(:version_1, Integer)
      param!(:version_2, Integer)

      version_1_text = extract_version_text(params[:version_1])
      version_2_text = extract_version_text(params[:version_2])
      diff = Diffy::Diff.new(version_1_text, version_2_text)

      generic_render(data: diff)
    end

    private

    def extract_version_text(version_param)
      version_object = Prompt.current.versions.find(version_param).object || ""
      version_data = YAML.safe_load(version_object, permitted_classes: [ Time ])
      version_data ? version_data["text"] : ""
    end
  end
end
