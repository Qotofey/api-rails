class NameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :bad_format) if self.class.valid?(value)
  end

  class << self
    def valid?(name)
      name.to_s =~ /\A[а-яё]+\z/i
    end
  end
end
