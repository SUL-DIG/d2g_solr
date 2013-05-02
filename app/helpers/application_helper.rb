module ApplicationHelper

  def on_scrollspy_page?
    on_about_pages
  end

  def params_for_session(session)
    {:f => {:session_date_sim => [session]}}
  end

  # sections for About page
  # elementlink names should match what's used in locale_about.yml
  def about_sections
    section_list = ['curator', 'project_team_stanford',
                    'project_team_bnf', 'technical_description',
                    'acknowledgements', 'use_and_reproduction']
  end

  # Used when search result views are in separate partials
  def link_to_search_result_view(icon, view_name, default_view)
    if default_view
      (params[:view] == "#{view_name}" or params[:view].nil?) ? view_state = 'active' : view_state = ''
    else
      params[:view] == "#{view_name}" ? view_state = 'active' : view_state = ''
    end

    link_to("<i class=#{icon}></i>".html_safe,
      catalog_index_path(params.merge(:view => "#{view_name}")),
      :alt => "#{view_name.titlecase} view of results",
      :title => "#{view_name.titlecase} view of results",
      :class => "#{view_state}")
  end

  # Used when search result views are in single partial
  def search_result_view_switch(icon, view_name, default_view)
    default_view ? view_state = 'active' : view_state = ''

    link_to("<i class=#{icon}></i>".html_safe, "##{view_name}",
      :data => {view: "#{view_name}"},
      :alt => "#{view_name.titlecase} view of results",
      :title => "#{view_name.titlecase} view of results",
      :class => "#{view_state}")
  end

def render_external_link args, results = Array.new
		text = args[:document].get(blacklight_config.show_fields[args[:field]][:text])
        url = args[:document].get(args[:field])
        link_text = 'Find This in SearchWorks'
        results << link_to(link_text, url, { :target => "_blank" }).html_safe
  end


end
