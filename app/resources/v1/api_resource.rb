class V1::APIResource < ApplicationResource
  self.abstract_class = true

  def self.infer_model
    name&.split('::').last&.gsub('Resource', '')&.safe_constantize
  end
end
