class NameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :bad_format) unless valid_name?(value)
  end

  def valid_name?(name)
    name.to_s =~ /\A[a-zа-яё]*\z/i
  end
end
