module ListsHelper

  def color_status(status)
    return "verde.png" if status
    return "azul.png" unless status
  end

  def button_option_task(status)
    return "success" unless status
    return "warning" if status
  end

  def frase_option_task(status)
    return "Finalizar" unless status
    return "Reativar" if status
  end

  def action_task(status)
    return "desable" unless status
    return "enable" if status
  end
end
