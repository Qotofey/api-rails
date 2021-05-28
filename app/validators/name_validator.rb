class NameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    result = value =~ /\A[а-яё]*\z/i
    record.errors[attribute] << :bad_format if result.nil?
  end
end
