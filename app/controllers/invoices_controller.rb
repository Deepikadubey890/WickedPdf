class InvoicesController < ApplicationController
    def new 
      @invoice = Invoice.new
    end 

   # def index
   #   @q = Invoice.ransack(params[:q])
   #   @invoices = @q.result(distinct: true)
   #    per_page = 5
   #    #  @invoices = scope

   #    # @invoices = Invoice.all
   #    # @pagy, @invoices = pagy(Invoice.all)
   #    total_invoices = @invoices.count
   #    if total_invoices > per_page
   #      @pagy, @invoices = pagy(@invoices, items: per_page)
   #    end
   #  end

   def index
      # debugger
      @q = Invoice.ransack(params[:q])
      @invoices = @q.result(distinct: true)
      per_page = 5
      @pagy, @invoices = pagy(@invoices, items: per_page)
  end

  #  def index
  #  #    debugger
  #   @pagy, @invoices = pagy(Invoice.all)
  # end
      


     def create
        @invoice = Invoice.new(invoice_params)
        if @invoice.save
          redirect_to @invoice, notice: 'Invoice was successfully created.'
        else
          render :new
        end  
     end


    def show
        @invoice = Invoice.find(params[:id])
        if @invoice
        respond_to do |format|
            format.html
            format.pdf do
                render pdf: "Invoice No. #{@invoice.id}",
                page_size: 'A4',
                template: "invoices/show.html.erb",
                layout: "pdf.html",
                orientation: "Landscape",
                lowquality: true,
                zoom: 1,
                dpi: 75
            end
        end
        else
        redirect_to invoices_path, alert: 'Invoice not found.'
     end
    end

    private
        def scope
            ::Invoice.all.includes(:invoice_items)
        end

    def invoice_params
     params.require(:invoice).permit(:full_name, :address, :name, :email, :phone, :status, :discount, :pdf_file)
    end    
end
