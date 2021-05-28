class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    result = value =~ /\A7[3489]\d{9}\z/
    record.errors[attribute] << :bad_format if result.nil?
  end
end
