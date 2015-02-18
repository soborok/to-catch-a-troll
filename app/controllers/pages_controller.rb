class PagesController < ApplicationController

before_action :authenticate_user!

  def search
  @query = SearchQuery.find_by(user_id: current_user.id)
  user_terms = @query.search_array if @query
  the_targets = params[:target]
    puts params
    puts the_targets

    if user_terms
      @usersearch = Page.search do
        with(:target_id).any_of(the_targets) if the_targets
        fulltext user_terms do
          highlight :body
        end
      end
      @results_found = @usersearch.hits

    else
      @message = "No results found"
    end
  end

end
