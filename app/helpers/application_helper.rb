module ApplicationHelper
  def flash_class(type)
    case type
    when 'notice'
      'text-blue-600 bg-blue-100'
    when 'alert'
      'text-red-600 bg-red-100'
    when 'success'
      'text-green-600 bg-green-100'
    when 'warning'
      'text-yellow-600 bg-yellow-100'
    else
      'text-gray-600 bg-gray-100'
    end
  end
end
