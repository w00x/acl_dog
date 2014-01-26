class AclsController < ApplicationController
  before_action :set_acl, only: [:show, :edit, :update, :destroy]

  # GET /acls
  # GET /acls.json
  def index
    @acls = Acl.all
  end

  # GET /acls/1
  # GET /acls/1.json
  def show
  end

  # GET /acls/new
  def new
    @acl = Acl.new
  end

  # GET /acls/1/edit
  def edit
  end

  # POST /acls
  # POST /acls.json
  def create
    @acl = Acl.new(acl_params)

    respond_to do |format|
      if @acl.save
        format.html { redirect_to @acl, notice: 'Acl was successfully created.' }
        format.json { render action: 'show', status: :created, location: @acl }
      else
        format.html { render action: 'new' }
        format.json { render json: @acl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acls/1
  # PATCH/PUT /acls/1.json
  def update
    respond_to do |format|
      if @acl.update(acl_params)
        format.html { redirect_to @acl, notice: 'Acl was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @acl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acls/1
  # DELETE /acls/1.json
  def destroy
    @acl.destroy
    respond_to do |format|
      format.html { redirect_to acls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acl
      @acl = Acl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acl_params
      params.require(:acl).permit(:action, :controller, :role_id)
    end
end
