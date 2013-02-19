# import Regexp

class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # POST /users/login
  def userLogin
    @result = User.login(params[:user], params[:password])
    if @result >= 1
      render :json => { 'errCode' => 1, 'count' => @result }
    else
      render :json => { 'errCode' => @result }
    end
  end

  # POST /users/add
  def userAdd
    @result = User.add(params[:user], params[:password])
    if @result > 0
      render :json => { 'errCode' => 1, 'count' => @result }
    else
      render :json => { 'errCode' => @result }
    end
  end

  # POST /TESTAPI/resetFixture
  def userResetFixture
    @result = User.resetFixture
    render :json => { 'errCode' => @result }
  end

  # POST /TESTAPI/unitTests
  def userUnitTests
    @unit_test_output = `rake test:units`
    #print "UNITTESTOUTPUT"+@unit_test_output
    #we need to find the line that starts with "[Number] tests"
    # @results = ''
    # @unit_test_output.each_line do |li|
    # if (li[/^[0-9]+ tests.*/])
    #   @results = li
    # end
    #end
    #/[0-9]+ tests/ =~ @results
    #/[0-9]+/ =~ Regexp.last_match[0]
    # @total_tests = Regexp.last_match[0].to_i
    @total_tests = 0
    # /[0-9]+ failures/ =~ @results
    # /[0-9]+/ =~ Regexp.last_match[0]
    # @failures = Regexp.last_match[0].to_i
    @failures = 0
    render :json => { 'totalTests' => @total_tests, 'nrFailed' => @failures, 'output' => @unit_test_output }
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
