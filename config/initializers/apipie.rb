Apipie.configure do |config|
  config.app_name = 'Community Reminiscens'
  config.copyright = "Community Reminiscens &copy; copyright #{Time.now.year}. all rights reserved."
  config.api_base_url['1'] = ''
  config.doc_base_url = '/apidoc'
  # were is API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.default_version = '1'
  config.use_cache = false
  config.app_info = 'Community Reminiscens API documentation.'
  config.languages = %w(en it)
  config.default_locale = 'en'
  config.locale = lambda { |loc| loc ? I18n.locale = loc : I18n.locale }
  config.translate = lambda do |str, loc|
    if str.present?
      old_loc = I18n.locale
      I18n.locale = loc
      trans = I18n.t(str)
      I18n.locale = old_loc
      trans
    else
      str
    end
  end
end

# special type of validator: we say that it's not specified
class UndefValidator < Apipie::Validator::BaseValidator

  def validate(value)
    true
  end

  def self.build(param_description, argument, options, block)
    if argument == :undef
      self.new(param_description)
    end
  end

  def description
    nil
  end
end

class Apipie::Validator::TypeValidator
  def description
    @type.name
  end
end

class Apipie::Validator::HashValidator
  def description
    'Hash'
  end
end

class NumberValidator < Apipie::Validator::BaseValidator

  def validate(value)
    value.to_s =~ /^(0|[1-9]\d*)$/
  end

  def self.build(param_description, argument, options, block)
    if argument == :number
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be a number, got: #{@error_value}"
  end

  def description
    'Number'
  end
end

class IdentifierValidator < Apipie::Validator::BaseValidator

  def validate(value)
    value = value.to_s
    value =~ /\A[\w| |_|-]*\Z/ && value.strip == value && (2..128).include?(value.length)
  end

  def self.build(param_description, argument, options, block)
    if argument == :identifier
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be an identifier, got: #{@error_value}"
  end

  def description
    "string from 2 to 128 characters containting only alphanumeric characters, space, '_', '-' with no leading or trailing space.."
  end
end

class BooleanValidator < Apipie::Validator::BaseValidator

  def validate(value)
    %w[true false True False].include?(value.to_s)
  end

  def self.build(param_description, argument, options, block)
    if argument == :bool
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be a boolean value, got: #{@error_value}"
  end

  def description
    'Boolean'
  end
end


class StringOrArrayValidator < Apipie::Validator::BaseValidator

  def validate(value)
    value.is_a?(Array) || value.is_a?(String)
  end

  def self.build(param_description, argument, options, block)
    if argument == :string_or_array
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be a String or Array, got: #{@error_value}"
  end

  def description
    'String Or Array'
  end
end


class FloatValidator < Apipie::Validator::BaseValidator

  def validate(value)
    value = value.to_s
    value =~ /^[-+]?[0-9]*\.?[0-9]+$/
  end

  def self.build(param_description, argument, options, block)
    if argument == :float
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be a float value, got: #{@error_value}"
  end

  def description
    'Float'
  end
end

class EmailAddressValidator < Apipie::Validator::BaseValidator

  def validate(value)
    value = value.to_s
    value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end

  def self.build(param_description, argument, options, block)
    if argument == :email_address
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be a email address, got: #{@error_value}"
  end

  def description
    'Email address'
  end
end

class StringStrictValidator < Apipie::Validator::BaseValidator

  def validate(value)
    return false unless value.present?
    value.is_a? String
  end

  def self.build(param_description, argument, options, block)
    if argument == :string_strict
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be a string value, got: #{@error_value}"
  end

  def description
    'String'
  end
end

class StringValidator < Apipie::Validator::BaseValidator

  def validate(value)
    value.is_a? String
  end

  def self.build(param_description, argument, options, block)
    if argument == :string
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be a string value, got: #{@error_value}"
  end

  def description
    'String'
  end
end

class ArrayValidator < Apipie::Validator::BaseValidator

  def validate(value)
    value.is_a?(Array)
  end

  def self.build(param_description, argument, options, block)
    if argument == :array
      self.new(param_description)
    end
  end

  def error
    "Parameter #{param_name} expecting to be a Array, got: #{@error_value}"
  end

  def description
    'Array'
  end
end
