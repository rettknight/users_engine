module Users
  module ApplicationHelper
	def title
    base_title = ""
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  	def add_picture(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to name, "#", :onclick => h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), title: title, remote: true
  	end
  end
end
