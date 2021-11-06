class SlugValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :bad_format) unless valid_email?(value)
  end

  def valid_email?(slug)
    slug.to_s =~ /\A[a-z\d_]*\z/
  end
end
