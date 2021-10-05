# frozen_string_literal: true

# возвращает true если оюъект валидный и false если не валидный
module Valid
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
