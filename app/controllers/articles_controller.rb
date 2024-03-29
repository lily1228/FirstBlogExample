class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.published.page(params[:page]).per(5).ordered

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new(:article=>@article)

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml

  
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @article }
    end
  end
  # GET /articles/1/edit
  def edit
    authorize! :edit, @article
    @article =~ Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    authorize! :create, @article
    @article = Article.new(params[:article])
    @article.user_id = current_user.id

    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    authorize! :update, @article
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    authorize! :destroy, @article       
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml { head :ok }
    end
  end
end