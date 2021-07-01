class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :bad_format) unless self.class.valid?(value)
  end

  class << self
    def valid?(email)
      name, domain = email.split('@')

      return false unless valid_name?(name)
      return false unless valid_domain?(domain)

      true
    end

    def valid_name?(value)
      return false if value.include?('..')

      (value =~ /^[a-z0-9а-яё_.-]+$/i).present?
    end

    def valid_domain?(domain)
      levels = domain.split('.')
      return false unless levels.count.in? [2, 3]

      levels.each do |level|
        return false unless (level =~ /^[a-z0-9а-яё-]+$/i).present?
      end

      true
    end
  end
end
