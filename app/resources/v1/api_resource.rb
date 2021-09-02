class V1::APIResource < ApplicationResource
  self.abstract_class = true
  self.endpoint_namespace = '/api/v1'

  def self.infer_model
    name&.split('::').last&.gsub('Resource', '')&.safe_constantize
  end
end
