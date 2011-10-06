require 'spec_helper'

describe RecipesController do

  before(:each) do
    login_user

    @recipe = mock("recipe")
    @user_recipes = mock("user recipes", :build => @recipe)
    @user.stub!(:recipes).and_return(@user_recipes)
  end

  it "should require authenticated user" do
    logout_user

    get :index

    response.should redirect_to(:controller => "login", :action => "index")
  end

  it "should load my recipes on index" do
    get :index

    assigns[:recipes].should == @user_recipes
  end

  it "should load all recipes on all" do
    recipes = mock("recipes")
    Recipe.should_receive(:find).with(:all, :order => "title").and_return(recipes)

    get :all

    assigns[:recipes].should == recipes
  end

  it "should render index on all" do
    get :all

    response.should render_template("recipes/index")
  end

  it "should load recipe specified on show" do
    Recipe.should_receive(:find).with("456").and_return(@recipe)
    # controller.should_receive(:render).with(:template => "recipes/show")

    get :show, :id => "456", :format => "html"

    assigns[:recipe].should == @recipe
  end

  it "should not render template on show for iphone" do
    Recipe.should_receive(:find).with("123").and_return(@recipe)
    # controller.should_receive(:render).with(:layout => false)

    get :show, :id => "123", :format => "iphone"

    assigns[:recipe].should == @recipe
  end

  it "should load recipe specified on edit" do
    @user_recipes.should_receive(:find).with("edit").and_return(@recipe)

    get :edit, :id => "edit"

    assigns[:recipe].should == @recipe
  end

  it "should show an error page if attempting to edit a recipe that is not owned by user" do
    @user_recipes.should_receive(:find).with("not_mine").and_raise ActiveRecord::RecordNotFound

    get :edit, :id => "not_mine"

    response.should render_template("recipes/not_found")
  end


  it "should instantiate new recipe on new" do
    @user_recipes.should_receive(:build).and_return(@recipe)

    get :new

    assigns[:recipe].should == @recipe
  end

  describe RecipesController, "recipe creation" do

    before(:each) do
      @params = {"title" => "tossed salad"}
    end

    it "should create a new recipe" do
      @user_recipes.should_receive(:build).with(@params).and_return(@recipe)
      @recipe.should_receive(:save!)

      post :create, :recipe => @params

      response.should redirect_to("http://test.host/recipes")
      assigns[:recipe].should == @recipe
      flash[:message].should == "Successfully created recipe"
    end

    it "should render new if create failed" do
      @real_recipe = Recipe.new
      @recipe.should_receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(@real_recipe))

      post :create, :recipe => @params

      response.should render_template("recipes/new")
      assigns[:recipe].should == @recipe
    end

  end

  it "should update a recipe" do
    @user_recipes.should_receive(:find).with("234").and_return(@recipe)
    @recipe.should_receive(:update_attributes).with({"name" => "chicken pot pie"}).and_return(true)

    post :update, :id => "234", :recipe => {"name" => "chicken pot pie"}

    response.should redirect_to("http://test.host/recipes")
    flash[:message].should == "Successfully updated recipe"
  end

  it "should render edit if update fails" do
    @user_recipes.should_receive(:find).with("234").and_return(@recipe)
    @recipe.should_receive(:update_attributes).with({"name" => "chicken pot pie"}).and_return(false)

    post :update, :id => "234", :recipe => {"name" => "chicken pot pie"}

    response.should render_template("recipes/edit")
  end

  it "should destroy a recipe" do
    @user_recipes.should_receive(:find).with("345").and_return(@recipe)
    @recipe.should_receive(:destroy).and_return(true)

    post :destroy, :id => "345"

    response.should redirect_to("http://test.host/recipes")
    flash[:message].should == "Successfully deleted recipe"
  end

  it "should show an error page if user tries to delete a recipe that is not theirs" do
    @user_recipes.should_receive(:find).with("not_mine").and_raise ActiveRecord::RecordNotFound

    post :destroy, :id => "not_mine"

    response.should render_template("recipes/not_found")
  end


  it "should search for recipes" do
    recipe = mock("recipe")
    @user_recipes.should_receive(:find).with(:all, {:conditions => ["title LIKE ? OR preparation LIKE ? OR source LIKE ?", "%Salad%", "%Salad%", "%Salad%"]}).and_return(recipe)

    post :search, :query => "Salad"

    assigns[:recipes].should == recipe
    response.should render_template("recipes/index")
  end

end
