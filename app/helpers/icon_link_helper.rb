module IconLinkHelper

  def view_icon_link(url, label='View')
   link_to raw("#{fa_icon('book 2x')} #{label}"), url, class: 'icon-link'
  end

 def edit_icon_link(url, label='Edit')
  link_to raw("#{fa_icon('edit 2x')} #{label}"), url, class: 'icon-link'
 end

 def back_icon_link(url, label='Back')
  link_to raw("#{fa_icon('mail-reply 2x')} #{label}"), url, class: 'icon-link'
 end

 def delete_icon_link(url, label='Delete')
  link_to raw("#{fa_icon('trash 2x')} Delete"), url, method: :delete, data: { confirm: 'Are you sure?' }, class: 'icon-link'
 end

end
