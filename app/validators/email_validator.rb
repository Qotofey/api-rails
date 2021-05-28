class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    result = value =~ /\A[a-z._-]+@[a-z._-]{3,}\z/i
    record.errors[attribute] << :bad_format if result.nil?
  end

  class << self
    def valid_email?(email)
      name, domain = email.split('@')

      return false if valid_name?(name)
      return false if valid_domain?(domain)

      true
    end

    def valid_name?(value)
      (value =~ /^[a-z0-9_.-]*$/i).present?
    end

    def valid_domain?(value)
      return false if [email_name.first, email_name.last].include?('.')
      return false if [value[0], value[-1]].include?('.')

      (value =~ /^[+a-z0-9_.-]*$/i).present?
    end
  end
end
