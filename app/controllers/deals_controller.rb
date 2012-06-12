class DealsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  # GET /deals
  # GET /deals.json
  def index
    @deals = Deal.all
    respond_with(@deals)
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    @deal = Deal.find(params[:id])
    respond_with(@deal)
  end

  # GET /deals/new
  # GET /deals/new.json
  def new
    @deal = Deal.new
    respond_with(@deal)
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(params[:deal])
    if @deal.save
      flash[:notice] = 'Deal was successfully created.'
    end
    respond_with(@deal, :location => deals_url)
  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    @deal = Deal.find(params[:id])
    @deal.verified = false

    if @deal.update_attributes(params[:deal])
      flash[:notice] = 'Deal was successfully updated.'
    end
    respond_with(@deal)
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy
    flash[:notice] = 'Deal was successfully deleted.'
    respond_with(@deal)
  end

  def verify
    @deal = Deal.find(params[:id])
    @deal.verified = true

    if @deal.update_attributes(params[:deal])
      flash[:notice] = 'Deal was marked as verified.'
    end
    respond_with(@deal)
  end

  def unverify
    @deal = Deal.find(params[:id])
    @deal.verified = false

    if @deal.update_attributes(params[:deal])
      flash[:notice] = 'Deal was marked as unverified.'
    end
    respond_with(@deal)
  end
end



