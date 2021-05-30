class SlugValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    result = value =~ /\A[a-z\d_]\z/
    record.errors[attribute] << :bad_format if result.nil?
  end
end
