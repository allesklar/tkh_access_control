class ReceptionMailer < ActionMailer::Base


  if Setting.first.present? && Setting.first.site_name.present? && Setting.first.contact_email.present?
    # the tkh_admin_panel gem is being used and configured properly
    default from: "#{Setting.first.try(:site_name)} <#{Setting.first.contact_email}>"
  else
    # no site setting record is being set
    # FIXME - find a better solution
    default from: "No Name <no-address-given@example.com"
  end

  def verification_email(user)
    @user = user
    mail(to: @user.email, subject: "Email validation for #{Setting.first ? Setting.first.try(:site_name) : 'No Site Name Given'}")
  end

  def password_creation_verification_email(user)
    @user = user
    mail(to: @user.email, subject: "Password creation confirmation for #{Setting.first ? Setting.first.try(:site_name) : 'No Site Name Given'}")
  end

  def new_password_request_email(user)
    @user = user
    mail(to: @user.email, subject: "New Password Request for #{Setting.first ? Setting.first.try(:site_name) : 'No Site Name Given'}")
  end

end
