"""Airesume_project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path

from Airesume_app import views
from Airesume_project import settings

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',views.log),
    path('log_post',views.log_post),
    path('adminhome',views.adminhome),
    path('view_verify_company',views.view_verify_company),
    path('view_verified_company',views.view_verified_company),
    path('view_candidates',views.view_candidates),
    path('view_review_rating',views.view_review_rating),
    path('view_feedback',views.view_feedback),
    path('view_complaints',views.view_complaints),
    path('view_complaints',views.view_complaints),
    path('send_reply/<id>',views.send_reply),
    path('send_reply_post/<id>',views.send_reply_post),
    path('view_reply',views.view_reply),
    path('accept_company/<id>',views.accept_company),
    path('reject_company/<id>',views.reject_company),
    path('Changepassword',views.Changepassword),
    path('Changepassword_post',views.Changepassword_post),



    #-----------COMPANY-------------------
    path('register',views.register),
    path('register_post',views.register_post),
    path('Companychangepassword',views.Companychangepassword),
    path('Companychangepassword_post',views.Companychangepassword_post),
    path('view_profile',views.view_profile),
    path('view_profile_post',views.view_profile_post),
    path('vaccancyadd', views.vaccancyadd),
    path('viewvaccancy', views.viewvaccancy),
    path('vaccancyadd_post', views.vaccancyadd_post),
    path('editvaccancy/<id>', views.editvaccancy),
    path('editvaccancy_post/<id>', views.editvaccancy_post),
    path('deletevaccancy/<id>', views.deletevaccancy),
    path('shortlist_resume/<id>', views.shortlist_resume),
    path('view_vaccancy_request', views.view_vaccancy_request),
    path('add_interview_schedule/<id>', views.add_interview_schedule),
    path('add_interview_schedule_post/<id>',views.add_interview_schedule_post),
    path('view_shortlisted_candidates',views.view_shortlisted_candidates),
    path('companyhome',views.companyhome),
    path('view_interview_schedule/<id>',views.view_interview_schedule),
    path('companyview_shecdule/<id>', views.companyview_shecdule),
    path('view_vaccancy',views.view_vaccancy),
    path('view_review', views.view_review),
    path('addquestions/<id>',views.addquestions),
    path('addquestions_post/<id>', views.addquestions_post),
    path('logout',views.logouts),
    path('editquestion/<id>',views.editquestion),
    path('editquestions_post/<id>',views.editquestions_post),
    path('deletequestions/<id>',views.deletequestions),
    path('add_exam_schedule/<id>',views.add_exam_schedule),
    path('add_exam_schedule_post/<id>',views.add_exam_schedule_post),
    path('viewquestion/<id>',views.viewquestion),
    path('forgotpassword',views.forgotpassword),
    path('forgotpasswordbuttonclick',views.forgotpasswordbuttonclick),
    path('otp',views.otp),
    path('otpbuttonclick',views.otpbuttonclick),
    path('forgotpswdpswed',views.forgotpswdpswed),
    path('forgotpswdpswedbuttonclick',views.forgotpswdpswedbuttonclick),


    #-----------USER--------------------------------------
    path('user_register_post',views.user_register_post),
    path('user_login_post',views.user_login_post),
    path('user_profile',views.user_profile),
    path('user_vaccancy',views.user_vaccancy),
    path('send_review',views.send_review),
    path('view_reply',views.view_reply),
    path('send_complaints',views.send_complaints),
    path('user_appliedlist',views.user_appliedlist),
    path('user_shortlistedlist', views.user_shortlistedlist),
    path('view_examdate',views.view_examdate),
    path('user_selectedlist',views.user_selectedlist),
    path('change_password_user',views.change_password_user),
    path('user_view_company',views.user_view_company),
    path('view_user_questions',views.view_user_questions),
    path('user_edit_profile',views.user_edit_profile),
    path('user_send_feedback',views.user_send_feedback),
    path('send_vaccancy_request',views.send_vaccancy_request),
    path('view_exam_date',views.view_exam_date),
    path('submit_exam',views.submit_exam),
    path('userviewquestions',views.userviewquestions),
    path('forgotemail', views.forgotemail),
    path('forgotpass', views.forgotpass),
    path('userviewexamresult', views.userviewexamresult),

    path("generate_exam", views.generate_exam),
    path("evaluate_exam", views.evaluate_exam),






]
urlpatterns+=static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)