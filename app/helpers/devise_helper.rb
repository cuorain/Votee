module DeviseHelper
#エラーメッセージをbootstrapにするためにこのメソッドをオーバーライド（上書き）
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <button type="button" class="close" data-dismiss="alert">
        <span aria-hidden="true">&times;</span>
      </button>
      <strong>
       #{pluralize(resource.errors.count, "件")}のエラーがあります
      </strong>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def bootstrap_class_for(flash_type)
      case flash_type
          when "success"
          "success"
          when "error"
          "danger"
          when "alert"
          "warning"
          when "notice"
          "info"
          else
          flash_type.to_s
      end
  end
end
