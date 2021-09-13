class Admin::ReportsController < AdminController
  def general
    send_data Pdf::General.begin(User.all).render,
              filename: 'geral.pdf',
              type: 'application/pdf'
  end
end
