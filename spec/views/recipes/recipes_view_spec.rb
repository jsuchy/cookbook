require 'spec_helper'

describe "Recipes View Spec" do
  before(:each) do
    @chowder = mock_model(Recipe, :id => 111, :title => "chowder")
    @burger = mock_model(Recipe, :id => 222, :title => "burger")
    @recipe = mock_model(Recipe, :title => nil, :source => nil, :yield => nil, :prep_time => nil,
                                 :cook_time_hours => nil, :cook_time_minutes => nil, :preparation => nil,
                                 :bake_temperature => nil, :image_url => nil, :belongs_to_user? => false)
  end

  describe "recipes/index" do
    before(:each) do
      assign(:recipes, [@chowder, @burger])
    end

    it "lists all recipes" do
      render :template => "recipes/index.html.erb"

      rendered.should =~ /chowder/
      rendered.should =~ /burger/
    end

    it "displays 'none found' message if no recipes displayed" do
      assign(:recipes, [])

      render :template => "recipes/index.html.erb"

      rendered.should =~ /No Recipes Found/
    end

    it "should not display the flash if not set" do
      render :template => "recipes/index.html.erb"

      rendered.should_not =~ /class=flash/
    end

    it "should display the flash if set" do
      flash[:notice] = "Something happened"

      render :template => "recipes/index.html.erb"

      rendered.should =~ /Something happened/
    end
  end

  describe "recipes/show" do
    before(:each) do
      assign(:recipe, @recipe)
      session[:user_id] = 222
    end

    it "should have a delete link if recipe belongs to user" do
      @recipe.should_receive(:belongs_to_user?).with(session[:user_id]).and_return(true)

      render :template => "recipes/show.html.erb"

      rendered.should =~ /Delete Recipe/
    end

    it "should have an edit link if recipe belongs to user" do
      @recipe.should_receive(:belongs_to_user?).with(session[:user_id]).and_return(true)

      render :template => "recipes/show.html.erb"

      rendered.should =~ /Edit Recipe/
    end

    it "should not have edit or delete link if recipe does not belong to logged in user" do
      @recipe.should_receive(:belongs_to_user?).with(session[:user_id]).and_return(false)

      render :template => "recipes/show.html.erb"

      rendered.should_not =~ /Delete Recipe/
      rendered.should_not =~ /Edit Recipe/
    end
  end

  describe "recipes/edit" do
    before(:each) do
      assign(:recipe, @recipe)
    end

    it "should have a cancel link" do
      render :template => "recipes/edit.html.erb"

      rendered.should =~ /Cancel/
    end
  end

  describe "recipes/new" do
    before(:each) do
      assign(:recipe, @recipe)
    end

    it "should have a cancel link" do
      render :template => "recipes/new.html.erb"

      rendered.should =~ /Cancel/
    end
  end
end
