class SlugValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :bad_format) if self.class.valid?(value)
  end

  class << self
    def valid?(slug)
      slug.to_s =~ /\A[a-z\d_]+\z/
    end
  end
end
