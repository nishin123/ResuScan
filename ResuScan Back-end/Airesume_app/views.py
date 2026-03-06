import datetime
import random
import smtplib

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import check_password, make_password
from django.contrib.auth.models import Group
from django.core.files.storage import FileSystemStorage
from django.core.serializers import json
from django.db.models import Q
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.views.decorators.cache import never_cache

from Airesume_app.models import *



def log(request):
    return render(request,'login.html')


# def log_post(request):

from django.contrib.auth import authenticate, login
from django.http import HttpResponse
from django.contrib.auth.models import User
from .models import company  # Make sure your model name is correct


def log_post(request):
    if request.method == "POST":
        username = request.POST.get('username')
        password = request.POST.get('password')

        print("Entered Username:", username)
        print("Entered Password:", password)

        user = authenticate(username=username, password=password)

        print("Authenticate Result:", user)

        if user is not None:
            login(request, user)
            print("Login Success")

            # Check if admin
            if user.is_superuser:
                print("Role: Admin")
                return HttpResponse(
                    "<script>alert('WELCOME ADMIN');window.location='/adminhome';</script>"
                )

            # Check if company
            elif user.groups.filter(name='company').exists():
                print("Role: Company")

                company_obj = company.objects.get(LOGIN=user.id)
                request.session['cid'] = company_obj.id

                print("Company ID Stored in Session:", company_obj.id)

                return HttpResponse(
                    "<script>alert('WELCOME COMPANY');window.location='/companyhome';</script>"
                )

            else:
                print("Role: Not matched")
                return HttpResponse(
                    "<script>alert('Invalid Role');window.location='/';</script>"
                )

        else:
            print("Authentication Failed")
            return HttpResponse(
                "<script>alert('Invalid Username or Password');window.location='/';</script>"
            )

    return HttpResponse(
        "<script>alert('Invalid Request');window.location='/';</script>"
    )


#     username=request.POST['email']
#     password=request.POST['password']
#     data=authenticate(username=username,password=password)
#     print(data)
#     if data is not  None:
#         login(request,data)
#         if data.is_superuser:
#             return HttpResponse("<script>alert('WELCOME ADMIN');window.location='/adminhome';</script>")
#         elif data.groups.filter(name='company').exists():
#             request.session['cid']=company.objects.get(LOGIN=request.user.id).id
#             return HttpResponse("<script>alert('WELCOME COMPANY');window.location='/companyhome';</script>")
#         return HttpResponse("<script>alert('Invalid');window.location='/';</script>")
#     return HttpResponse("<script>alert('Invalid');window.location='/';</script>")

@login_required
@never_cache
def adminhome(request):
    return render(request,'admin/adminindex.html')

@login_required
@never_cache
def view_verify_company(request):
    data=company.objects.filter(status='pending')
    return render(request,'admin/view_verify_company.html',{'data':data})

@login_required
@never_cache
def accept_company(request,id):
    company.objects.filter(id=id).update(status="accepted")
    return HttpResponse("<script>alert('ACCEPTED');window.location='/view_verified_company';</script>")

@login_required
@never_cache
def reject_company(request,id):
    company.objects.filter(id=id).update(status="rejected")
    return HttpResponse("<script>alert('REJECTED');window.location='/view_verify_company';</script>")

@login_required
@never_cache
def view_verified_company(request):
    data=company.objects.filter(status='accepted')
    return render(request,'admin/view_verified_company.html',{'data':data})

@login_required
@never_cache
def view_candidates(request):
    data=user.objects.all()
    return render(request,'admin/viewcandidates.html',{'data':data})

@login_required
@never_cache
def view_review_rating(request):
    data=review.objects.all()
    return render(request,'admin/view_review_rating.html',{'data':data})

@login_required
@never_cache
def view_feedback(request):
    data=feedback.objects.all()
    return render(request,'admin/view_feedback.html',{'data':data})

@login_required
@never_cache
def view_complaints(request):
    data=complaintss.objects.all()
    return render(request,'admin/view_complaints.html',{'data':data})

@login_required
@never_cache
def send_reply(request,id):
    data=complaintss.objects.get(id=id)
    return render(request,'admin/sentreply.html',{'data':data,'id':id})

@login_required
@never_cache
def send_reply_post(request,id):
    reply=request.POST['reply']
    complaintss.objects.filter(id=id).update(reply=reply,reply_date=datetime.datetime.now().date())
    return HttpResponse("<script>alert('REPLY SEND SUCCESSFULLY');window.location='/adminhome';</script>")

@login_required
@never_cache
def view_reply(request):
    data=complaintss.objects.all()
    return render(request,'admin/view_complaints_reply.html',{'data':data})

@login_required
@never_cache
def Changepassword(request):
    return render(request,'admin/Changepassword.html')

@login_required
@never_cache
def Changepassword_post(request):
    oldpassword=request.POST['textfield']
    newpassword=request.POST['textfield2']
    repeatpassword=request.POST['textfield3']
    if newpassword!=repeatpassword:
        return HttpResponse("<script>alert('Passwords do not match');window.location='/Changepassword';</script>")
    data=check_password(oldpassword,request.user.password)
    if data:
        user=request.user
        user.set_password(newpassword)
        user.save()
        return HttpResponse("<script>alert('Password Changed');window.location='/adminhome';</script>")


    return HttpResponse("<script>alert('Invalid');window.location='/adminhome';</script>")

def logouts(request):
    logout(request)
    return HttpResponse("<script>alert('Logged Out Successful');window.location='/';</script>")

############################################### COMPANY MODULE #################################################


def register(request):
    return render(request,'company/register.html')

def register_post(request):
    name=request.POST['name']
    email=request.POST['email']
    phone=request.POST['phone']
    place=request.POST['place']
    longitude=request.POST['longitude']
    latitude=request.POST['latitude']
    password=request.POST['password']
    confirmpassword=request.POST['confirmpassword']
    if User.objects.filter(username=email).exists():
        return HttpResponse("<script>alert('email already registered');window.location='/register';</script>")

    if password!=confirmpassword:
        return HttpResponse("<script>alert('Passwords do not match');window.location='/register';</script>")
    obj=User()
    obj.username=email
    obj.password=make_password(password)
    obj.save()
    obj.groups.add(Group.objects.get(name='company'))
    obj1=company()
    obj1.name=name
    obj1.place=place
    obj1.email=email
    obj1.phone=phone
    obj1.latitude=latitude
    obj1.longitude=longitude
    obj1.status='pending'
    obj1.LOGIN=obj
    obj1.save()
    return HttpResponse("<script>alert(' Registered ');window.location='/';</script>")

@login_required
@never_cache
def Companychangepassword(request):
    return render(request,'company/companychangepassword.html')

@login_required
@never_cache
def Companychangepassword_post(request):
    oldpassword=request.POST['textfield']
    newpassword=request.POST['textfield2']
    repeatpassword=request.POST['textfield3']
    if newpassword!=repeatpassword:
        return HttpResponse("<script>alert('Passwords do not match');window.location='/companychangepassword';</script>")
    data=check_password(oldpassword,request.user.password)
    if data:
        user=request.user
        user.set_password(newpassword)
        user.save()
        return HttpResponse("<script>alert('Password Changed');window.location='/companyhome';</script>")


    return HttpResponse("<script>alert('Invalid');window.location='/companyhome';</script>")

@login_required
@never_cache
def view_profile(request):
    data=company.objects.get(id=request.session['cid'])
    return render(request,'company/profile_view.html',{'data':data})

@login_required
@never_cache
def view_profile_post(request):
    name = request.POST['name']
    phone = request.POST['phone']
    place = request.POST['place']
    longitude = request.POST['longitude']
    latitude = request.POST['latitude']
    company.objects.filter(id=request.session['cid']).update(name=name,place=place,phone=phone,latitude=latitude,longitude=longitude)

    return HttpResponse("<script>alert(' Updated ');window.location='/view_profile';</script>")


@login_required
@never_cache
def vaccancyadd(request):
    return render(request,'company/vaccancyadd.html')

@login_required
@never_cache
def viewvaccancy(request):
    data=vaccancy.objects.all()
    return render(request,'company/view_vaccancy.html',{'data':data})

@login_required
@never_cache
def vaccancyadd_post(request):
    jobtitle=request.POST['textfield']
    description=request.POST['textarea']
    skill=request.POST['textarea2']
    experience=request.POST['textarea3']
    salary=request.POST['textfield2']
    fromdate=request.POST['textfield3']
    todate=request.POST['textfield4']
    if vaccancy.objects.filter(job_title=jobtitle,description=description,skills=skill,experience=experience,salary_range=salary,from_date=fromdate,to_date=todate).exists():
        return HttpResponse("<script>alert('Already Existed');window.location='/viewvaccancy'</script>")

    obj=vaccancy()
    obj.job_title=jobtitle
    obj.description=description
    obj.skills=skill
    obj.experience=experience
    obj.salary_range=salary
    obj.date=datetime.datetime.now().date()
    obj.status='pending'
    obj.from_date=fromdate
    obj.to_date=todate
    obj.COMPANY_id=request.session['cid']
    obj.save()
    return HttpResponse("<script>alert('Vaccancy Added');window.location='/viewvaccancy'</script>")

@login_required
@never_cache
def editvaccancy(request,id):
    data=vaccancy.objects.get(id=id)
    return render(request,'company/vaccancyedit.html',{'data':data,'id':id})

@login_required
@never_cache
def editvaccancy_post(request, id):
    jobtitle = request.POST['textfield']
    description = request.POST['textarea']
    skill = request.POST['textarea2']
    experience = request.POST['textarea3']
    salary = request.POST['textfield2']
    fromdate = request.POST['textfield3']
    todate = request.POST['textfield4']
    if vaccancy.objects.filter(job_title=jobtitle,description=description,skills=skill,experience=experience,salary_range=salary,from_date=fromdate,to_date=todate).exists():
        return HttpResponse("<script>alert('Already Existed');window.location='/viewvaccancy'</script>")

    vaccancy.objects.filter(id=id).update(job_title=jobtitle,description=description,skills=skill,experience=experience,salary_range=salary,from_date=fromdate,to_date=todate)
    return HttpResponse("<script>alert('Vaccancy Edited');window.location='/viewvaccancy'</script>")

@login_required
@never_cache
def deletevaccancy(request, id):
     vaccancy.objects.filter(id=id).delete()
     return HttpResponse("<script>alert('Vacancy Deleted');window.location='/viewvaccancy'</script>")

@login_required
@never_cache
def view_shortlisted_candidates(request):
    data=vaccancy_request.objects.filter(VACCANCY__COMPANY_id=request.session['cid'],status='shortlisted')
    return render(request,'company/view_shortlisted_candidates.html',{'data':data})

@login_required
@never_cache
def shortlist_resume(request,id):
    vaccancy_request.objects.filter(id=id).update(status="shortlisted")
    return HttpResponse("<script>alert('SHORTLISTED');window.location='/view_shortlisted_candidates';</script>")


@login_required
@never_cache
def view_vaccancy_request(request):
    data=vaccancy_request.objects.filter(VACCANCY__COMPANY_id=request.session['cid'])
    return render(request,'company/view_vaccancy_request.html',{'data':data})

@login_required
@never_cache
def add_interview_schedule(request,id):
    return render(request,'company/Interview Schedule.html',{'id':id})

@login_required
@never_cache
def add_interview_schedule_post(request,id):
    Date=request.POST['textfield']
    Time=request.POST['textfield2']
    vaccancy_request.objects.filter(id=id).update(interview_date=Date,interview_time=Time)
    return HttpResponse("<script>alert('Added');window.location='/view_vaccancy_request'</script>")

@login_required
@never_cache
def view_interview_schedule(request,id):
    data=vaccancy_request.objects.filter(VACCANCY__COMPANY=request.session['cid'])
    return render(request, 'company/view_interview_schedule.html', {'data':data})

@login_required
@never_cache
def companyview_shecdule(request,id):
    data=exam_schedule.objects.filter(VACANCY_REQUEST_id=id)
    return render(request,'company/view_exam_schedule.html', {'data':data})

@login_required
@never_cache
def add_exam_schedule(request,id):
    return render(request,'company/add_exam_schedule.html',{'id':id})

@login_required
@never_cache
def add_exam_schedule_post(request,id):
    date=request.POST['textfield']
    time=request.POST['textfield2']
    venue=request.POST['textfield3']
    if exam_schedule.objects.filter(date=date,time=time,venue=venue).exists():
        return HttpResponse("<script>alert('Already Existed');window.location='/view_vaccancy_request'</script>")
    obj=exam_schedule()
    obj.date=date
    obj.time=time
    obj.venue=venue
    obj.VACANCY_REQUEST_id=id
    obj.save()
    return HttpResponse("<script>alert('Exam Scheduled');window.location='/view_vaccancy_request'</script>")


#
# def companyview_shecdules(request,id):
#     data=exam_schedule.objects.filter(VACCANCY_REQUEST=id)
#     return render(request,'company/view_exam_schedule.html', {'data':data})
#

@login_required
@never_cache

def view_vaccancy(request):
    data=vaccancy.objects.all()
    return render(request,'company/view_vaccancy.html',{'data':data})

@login_required
@never_cache

def view_review(request):
    data=review.objects.filter(COMPANY=request.session['cid'])
    return render(request,'company/view_review_rating.html',{'data':data})

@login_required
@never_cache

def addquestions(request,id):
    return render(request,'company/addquestions.html',{'id':id})

@login_required
@never_cache

def addquestions_post(request,id):
    questions=request.POST['textarea']
    option_a=request.POST['textfield2']
    option_b=request.POST['textfield3']
    option_c=request.POST['textfield4']
    option_d=request.POST['textfield5']
    corrected_answer=request.POST['textfield6']
    if question.objects.filter(questions=questions,option_a=option_a,option_b=option_b,option_c=option_c,option_d=option_d,corrected_answer=corrected_answer).exists():
        return HttpResponse("<script>alert('Already Existed ');window.location='/view_vaccancy_request'</script>")

    obj=question()
    obj.questions=questions
    obj.option_a=option_a
    obj.option_b=option_b
    obj.option_c=option_c
    obj.option_d=option_d
    obj.EXAM_SCHEDULEE_id=id
    obj.corrected_answer=corrected_answer
    obj.save()
    return redirect(f'/view_interview_schedule/{id}')


@login_required
@never_cache

def editquestion(request,id):
    data = question.objects.get(id=id)
    return render(request,'company/edditquestions.html',{'data':data,'id':id})

@login_required
@never_cache

def editquestions_post(request,id):
    questions=request.POST['textarea']
    option_a=request.POST['textfield2']
    option_b=request.POST['textfield3']
    option_c=request.POST['textfield4']
    option_d=request.POST['textfield5']
    corrected_answer=request.POST['textfield6']
    if question.objects.filter(questions=questions,option_a=option_a,option_b=option_b,option_c=option_c,option_d=option_d,corrected_answer=corrected_answer).exists():
        return HttpResponse("<script>alert('Already Existed ');window.location='/viewquestion'</script>")

    question.objects.filter(id=id).update(questions=questions,option_a=option_a,option_b=option_b,option_c=option_c,option_d=option_d,corrected_answer=corrected_answer)
    return HttpResponse("<script>alert('Question Edited');window.location='/viewquestion'</script>")

@login_required
@never_cache

def viewquestion(request,id):
    data=question.objects.filter(EXAM_SCHEDULEE__VACANCY_REQUEST__VACCANCY__COMPANY=request.session['cid'],EXAM_SCHEDULEE__id=id)
    return render(request,'company/viewquestion.html',{'data':data,'id':id})

@login_required
@never_cache

def deletequestions(request,id):
    question.objects.filter(id=id).delete()
    return HttpResponse("<script>alert('Question deleted');window.location='/viewquestion'</script>")


@login_required
@never_cache
def companyhome(request):
    return render(request,'company/companyhome.html')


@login_required
@never_cache
def forgotpassword(request):
    return render(request,"forgotpassword.html")

@login_required
@never_cache
def forgotpasswordbuttonclick(request):
    email = request.POST['textfield']
    if User.objects.filter(username=email).exists():
        from email.mime.text import MIMEText
        from email.mime.multipart import MIMEMultipart

        # ✅ Gmail credentials (use App Password, not real password)
        sender_email = "scanresu@gmail.com"
        receiver_email = email  # change to actual recipient
        app_password = "agok alag xuzt uckh"  # App Password from Google
        pwd = str(random.randint(1100,9999))  # Example password to send
        request.session['otp'] = pwd
        request.session['email'] = email

        # Setup SMTP
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login(sender_email, app_password)

        # Create the email
        msg = MIMEMultipart("alternative")
        msg["From"] = sender_email
        msg["To"] = receiver_email
        msg["Subject"] = "Your OTP"

        # Plain text (backup)
        # text = f"""
        # Hello,

        # Your password for Smart Donation Website is: {pwd}

        # Please keep it safe and do not share it with anyone.
        # """

        # HTML (attractive)
        html = f"""
        <html>
          <body style="font-family: Arial, sans-serif; color: #333;">
            <h2 style="color:#2c7be5;">ResuScan</h2>
            <p>Hello,</p>
            <p>Your OTP is:</p>
            <p style="padding:10px; background:#f4f4f4; 
                      border:1px solid #ddd; 
                      display:inline-block;
                      font-size:18px;
                      font-weight:bold;
                      color:#2c7be5;">
              {pwd}
            </p>
            <p>Do not Reply Please keep it safe and do not share it with anyone else.</p>
            <hr>
            <small style="color:gray;">This is an automated email from ResuScan System.</small>
          </body>
        </html>
        """

        # Attach both versions
        # msg.attach(MIMEText(text, "plain"))
        msg.attach(MIMEText(html, "html"))

        # Send email
        server.send_message(msg)
        print("✅ Email sent successfully!")

        # Close connection
        server.quit()
        return HttpResponse("<script>window.location='/otp'</script>")
    else:
        return HttpResponse("<script>alert('Email not found');window.location='/forgotpassword'</script>")



def otp(request):
    return render(request,"otp.html")
def otpbuttonclick(request):
    otp  = request.POST["textfield"]
    if otp == str(request.session['otp']):
        return HttpResponse("<script>window.location='/forgotpswdpswed'</script>")
    else:
        return HttpResponse("<script>alert('incorrect otp');window.location='/otp'</script>")

def forgotpswdpswed(request):
    return render(request,"forgotpswdpswed.html")
def forgotpswdpswedbuttonclick(request):
    np = request.POST["password"]
    User.objects.filter(username=request.session['email']).update(password=make_password(np))
    return HttpResponse("<script>alert('password has been changed');window.location='/' </script>")




#------------------------------------------------------------------------USER----------------------------------------------------------------------------------#


def user_register_post(request):
    name=request.POST['name']
    email=request.POST['email']
    phone=request.POST['phone']
    place=request.POST['place']
    post=request.POST['post']
    pin=request.POST['pin']
    password=request.POST['password']
    confirmpassword=request.POST['confirmPassword']
    if password!=confirmpassword:
        return JsonResponse({'status':'invalid'})

    obj=User()
    obj.username=email
    obj.password=make_password(password)
    obj.save()
    obj.groups.add(Group.objects.get(name='user'))
    obj1=user()
    obj1.name=name
    obj1.place=place
    obj1.email=email
    obj1.phone=phone
    obj1.pin=pin
    obj1.post=post
    obj1.LOGIN_id=obj.id
    obj1.save()
    return JsonResponse({'status': 'ok'})

def user_login_post(request):
    username = request.POST['username']
    password = request.POST['password']
    data=authenticate(request,username=username,password=password)
    if data:
        login(request,data)
        if data.groups.filter(name="user").exists():
            uid=user.objects.get(LOGIN=request.user.id).id
            return JsonResponse({"status":"ok","uid":uid})
    else:
        return JsonResponse({"status": "invalid"})



def user_profile(request):
    uid=request.POST['uid']
    data=user.objects.filter(id=uid)
    message=[]
    for i in data:
        message.append({
            "id":i.id,
            "name":i.name,
            "place":i.place,
            "pin": i.pin,
            "post": i.post,
            "email": i.email,
            "phone": i.phone,
        })

    return JsonResponse({"status": "ok", "data": message})

def user_vaccancy(request):
    data=vaccancy.objects.all()
    message=[]
    for i in data:
        message.append({
            "id":i.id,
            "Job":i.job_title,
            "Description":i.description,
            "Skills": i.skills,
            "Experience": i.experience,
            "Salary": i.salary_range,
            "Date": i.date,
            "Status": i.status,
            "FromDate": i.from_date,
            "Todate": i.to_date,
            "cname":i.COMPANY.name,
            "place": i.COMPANY.place,

        })
    return JsonResponse({"status": "ok", "data": message})


def user_appliedlist(request):
    uid=request.POST['uid']
    print(uid)
    data = vaccancy_request.objects.filter(USER=uid)
    print(data)
    message = []
    for i in data:
        message.append({
            "id":i.id,
            "Resume": i.resume,
            "Status": i.status,
            "Date": i.date,
            "Interview_Date": i.interview_date,
            "Interview_Time": i.interview_time,
            "Schedule": i.schedule,
        })
    print(message)
    return JsonResponse({"status": "ok", "message": message})




def send_review(request):
    uid=request.POST['uid']
    cid=request.POST['cid']
    reviews=request.POST['reviews']
    rating=request.POST['rating']

    obj=review()
    obj.reviews=reviews
    obj.rating=rating
    obj.date=datetime.datetime.now().date()
    obj.USER_id=uid
    obj.COMPANY_id=cid
    obj.save()
    return JsonResponse({"status": "ok"})

def view_reply(request):
    uid=request.POST['uid']

    data = complaintss.objects.filter(USER=uid)
    message = []
    for i in data:
        message.append({
            "id":i.id,
            "date":i.date,
            "reply":i.reply,
            "name":i.USER.name,})

    return JsonResponse({"status": "ok", "data": message})


def send_complaints(request):
    uid=request.POST['uid']
    complaint=request.POST['complaints']
    obj=complaintss()
    obj.complaints=complaint
    obj.date=datetime.datetime.now().date()
    obj.USER_id=uid
    obj.reply='pending'
    obj.save()
    return JsonResponse({"status": "ok"})

def view_examdate(request):
    uid=request.POST['uid']
    data = exam_schedule.objects.filter(EXAM_SCHEDULE__USER=uid)
    message = []
    for i in data:
        message.append({
            "id":i.id,
            "Date": i.date,
            "Time": i.time,
            "Venue": i.venue,
            "jobtitle":i.VACCANCY_REQUEST.VACCANCY.job_title,
            'description':i.VACCANCY_REQUEST.VACCANCY.description,
        })

    return JsonResponse({"status": "ok", "data": message})

def user_shortlistedlist(request):
    uid=request.POST['uid']
    print(uid)
    data = vaccancy_request.objects.filter(USER=uid)
    print(data)
    message = []
    for i in data:
        score = exam_result.objects.filter(VACCANCY=i.id)
        if score.exists():
            message.append({
                "id":i.id,
                "score":i.score,
                "jobtitle": i.VACCANCY.job_title,
                'description': i.VACCANCY.description,
                "skills":i.VACCANCY.skills,
                "name":i.VACCANCY.COMPANY.name,
            })
        else:
            message.append({
                "id": i.id,
                "score": i.score,
                "jobtitle": i.VACCANCY.job_title,
                'description': i.VACCANCY.description,
                "skills": i.VACCANCY.skills,
                "name": i.VACCANCY.COMPANY.name,
            })
    print(message)
    return JsonResponse({"status": "ok", "message": message})

def view_user_questions(request):
    uid=request.POST['uid']
    sid=request.POST['sid']
    print(uid)
    print(sid)
    data = question.objects.filter(EXAM_SCHEDULEE_id=sid)
    print(data)
    message = []
    for i in data:
        message.append({
            "questions": i.questions,
            "option_a": i.option_a,
            "option_b": i.option_b,
            'option_c': i.option_c,
            "option_d": i.option_d,
        })
    print(message)
    return JsonResponse({"status": "ok", "message": message})


def user_selectedlist(request):
    uid=request.POST['uid']
    data = vaccancy_request.objects.filter(USER=uid,status='selected')
    message = []
    for i in data:
        message.append({
            "id": i.id,
            "Resume": i.resume,
            "Status": i.status,
            "Date": i.date,
            "Interview_Date": i.interview_date,
            "Interview_Time": i.interview_time,
            "Schedule": i.schedule,
        })

    return JsonResponse({"status": "ok", "message": message})



def change_password_user(request):
    uid=request.POST['uid']
    password=request.POST['password']
    newpassword=request.POST['newpassword']
    confirmpassword=request.POST['confirmpassword']
    if newpassword==confirmpassword:
        obj=User.objects.get(id=user.objects.get(id=uid).LOGIN_id)
        obj.set_password(newpassword)
        obj.save()
        return JsonResponse({"status":"ok"})
    else:
        return JsonResponse({"status": "invalid"})

def user_edit_profile(request):
    id=request.POST['uid']
    name=request.POST['name']
    place=request.POST['place']
    pin=request.POST['pin']
    post=request.POST['post']
    email=request.POST['email']
    phone=request.POST['phone']
    user.objects.filter(id=id).update(name=name,post=post,place=place,pin=pin,phone=phone,email=email)
    return JsonResponse({"status": "ok"})



def user_view_company(request):
    data=company.objects.all()
    ar=[]
    for i in data:
        ar.append({
            'id': i.id,
            'name':i.name,
            'place':i.place,
            'email':i.email,
            'phone':i.phone,

        })
    return JsonResponse({'status':'ok','data':ar})


def user_send_feedback(request):
    uid=request.POST['uid']
    ms=request.POST['feedback']
    obj=feedback()
    obj.message=ms
    obj.USER_id=uid
    obj.date=datetime.datetime.now().date()
    obj.save()
    return JsonResponse({'status':"ok"})


def send_vaccancy_request(request):
    vid=request.POST['id']
    uid=request.POST['uid']
    fil=request.FILES['file']
    fs=FileSystemStorage()
    path=fs.save(fil.name,fil)
    obj=vaccancy_request()
    obj.VACCANCY_id=vid
    obj.USER_id=uid
    obj.resume=fs.url(path)
    obj.status='pending'
    obj.date=datetime.datetime.now().date()
    obj.interview_date='pending'
    obj.interview_time='pending'
    obj.save()
    return JsonResponse({'status':'ok'})



def view_exam_date(request):
    uid = request.POST.get("uid")

    data = exam_schedule.objects.filter(
        VACANCY_REQUEST__USER_id=uid
    )

    message = []

    for es in data:
        vr = es.VACANCY_REQUEST
        vac = vr.VACCANCY
        comp = vac.COMPANY

        message.append({
            "id": es.id,
            "date": es.date,
            "interview_time": es.time,
            "status": vr.status,
            "job_title": vac.job_title,
            "details": vac.description,
            "from_date": vac.from_date,
            "last_date": vac.to_date,
            "jobprovider_name": comp.name,
        })

    return JsonResponse({
        "status": "ok",
        "data": message
    })




import json
from django.http import JsonResponse
from .models import exam_schedule, question, exam_result

def submit_exam(request):
    if request.method != "POST":
        return JsonResponse({"status": "error", "message": "Invalid request"})

    try:
        data = json.loads(request.body.decode("utf-8"))
    except Exception as e:
        print("JSON ERROR:", e)
        return JsonResponse({"status": "error", "message": "Invalid JSON"})

    uid = data.get("uid")
    exam_id = data.get("exam_id")
    answers = data.get("answers")

    print("UID:", uid)
    print("EXAM ID:", exam_id)
    print("ANSWERS:", answers)

    if not exam_id or not isinstance(answers, dict):
        return JsonResponse({"status": "error", "message": "Missing data"})

    try:
        exam = exam_schedule.objects.get(id=exam_id)
    except exam_schedule.DoesNotExist:
        return JsonResponse({"status": "error", "message": "Invalid exam"})

    # vr = exam.EXAM_SCHEDULE
    vr=exam.VACANCY_REQUEST
    vacancy = vr.VACCANCY

    saved_count = 0

    for qid, selected in answers.items():
        try:
            q = question.objects.get(id=qid)

            # Decide correct / wrong
            if q.corrected_answer == selected:
                score = f"selected:{selected}|correct"
            else:
                score = f"selected:{selected}|wrong"

            # ✅ SAVE TO DB
            exam_result.objects.create(
                score=score,
                VACCANCY=vacancy,
                QUESTION=q
            )

            saved_count += 1
            print("Saved result for question:", qid)

        except Exception as e:
            print("ERROR SAVING QUESTION", qid, e)

    print("TOTAL SAVED:", saved_count)

    # Update status (simple version)
    vr.status = "exam_completed"
    vr.save()

    return JsonResponse({
        "status": "ok",
        "saved": saved_count
    })




def userviewquestions(request):
    exam_id = request.GET.get("exam_id")

    if not exam_id:
        return JsonResponse({"status": "error", "message": "exam_id required"})

    data = question.objects.filter(EXAM_SCHEDULEE_id=exam_id)

    message = []
    for i in data:
        message.append({
            "id": i.id,
            "questions": i.questions,
            "answer": i.corrected_answer,
            "option_1": i.option_a,
            "option_2": i.option_b,
            "option_3": i.option_c,
            "option_4": i.option_d,
        })

    return JsonResponse({"status": "ok", "data": message})





def forgotemail(request):
    import random
    import smtplib
    email = request.POST['email']
    print(email)
    data = User.objects.filter(username=email)
    print(data)
    if data.exists():
        otp = str(random.randint(100000, 999999))
        print(otp)
        # *✨ Python Email Codeimport smtplib*

        from email.mime.text import MIMEText
        from email.mime.multipart import MIMEMultipart

        # ✅ Gmail credentials (use App Password, not real password)
        try:
            sender_email = "scanresu@gmail.com"
            receiver_email = email # change to actual recipient
            app_password = "agok alag xuzt uckh"
            # Setup SMTP
            server = smtplib.SMTP("smtp.gmail.com", 587)
            server.starttls()
            server.login(sender_email, app_password)

            # Create the email
            msg = MIMEMultipart("alternative")
            msg["From"] = sender_email
            msg["To"] = receiver_email
            msg["Subject"] = "🔑 Forgot Password "

            # Plain text (backup)
            # text = f"""
            # Hello,

            # Your password for Smart Donation Website is: {pwd}

            # Please keep it safe and do not share it with anyone.
            # """

            # HTML (attractive)
            html = f"""
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Password Reset OTP</title>
                </head>
                <body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
                            line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">

                    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                                padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
                        <h1 style="color: white; margin: 0; font-size: 28px;">
                            🔐 AI RESUME
                        </h1>
                    </div>

                    <div style="background-color: #f9f9f9; padding: 40px 30px; border-radius: 0 0 10px 10px; 
                                border: 1px solid #eaeaea;">

                        <h2 style="color: #2d3748; margin-top: 0;">Password Reset Request</h2>

                        <p style="color: #4a5568; font-size: 16px;">
                            Hello,
                        </p>

                        <p style="color: #4a5568; font-size: 16px;">
                            You requested to reset your password. Use the OTP below to proceed:
                        </p>

                        <div style="background: white; border-radius: 8px; padding: 20px; 
                                    text-align: center; margin: 30px 0; border: 2px dashed #cbd5e0;">
                            <div style="font-size: 32px; font-weight: bold; letter-spacing: 10px; 
                                        color: #2c7be5; margin: 10px 0;">
                                {otp}
                            </div>
                            <div style="font-size: 14px; color: #718096; margin-top: 10px;">
                                (Valid for 10 minutes)
                            </div>
                        </div>

                        <p style="color: #4a5568; font-size: 16px;">
                            Enter this code on the password reset page to complete the process.
                        </p>

                        <div style="background-color: #fef3c7; border-left: 4px solid #d97706; 
                                    padding: 15px; margin: 25px 0; border-radius: 4px;">
                            <p style="color: #92400e; margin: 0; font-size: 14px;">
                                ⚠️ <strong>Security tip:</strong> Never share this OTP with anyone. 
                                Our team will never ask for your password or OTP.
                            </p>
                        </div>

                        <p style="color: #718096; font-size: 14px;">
                            If you didn't request this password reset, please ignore this email or 
                            contact our support team if you have concerns.
                        </p>

                        <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 30px 0;">

                        <p style="text-align: center; color: #a0aec0; font-size: 12px;">
                            This is an automated email from ai resume System.<br>
                            © {datetime.datetime.now().date()} AI RESUME. All rights reserved.
                        </p>

                    </div>
                </body>
                </html>
                """

            # Attach both versions
            # msg.attach(MIMEText(text, "plain"))
            msg.attach(MIMEText(html, "html"))

            # Send email
            server.send_message(msg)
            print("✅ Email sent successfully!", otp)

            # Close connection
            server.quit()

        except Exception as e:
            print("❌ Error loading email credentials:", e)
            return JsonResponse({'status': "ok", 'otpp': otp})

        return JsonResponse({'status': 'ok', 'otpp': otp})
    return JsonResponse({'status': "not found"})


def forgotpass(request):
    email = request.POST['email']
    npass = request.POST['password']
    cpass = request.POST['confirmpassword']
    print(email, npass, cpass)
    if npass == cpass:
        User.objects.filter(username=email).update(password=make_password(npass))
        return JsonResponse({'status': 'ok'})
    return JsonResponse({'status': 'invalid'})


def userviewexamresult(request):
    exam_id = request.GET.get("exam_id")
    # if not exam_id:
    #     return JsonResponse({"status": "error", "message": "exam_id required"})

    user_id = request.session.get("uid")
    data = exam_result.objects.filter(
        VACANCY_REQUEST__exam_schedule__id=exam_id,
        VACANCY_REQUEST__USER_id=user_id
    )

    message = []
    for i in data:
        message.append({
            "id": i.id,
            "question": i.QUESTION.questions,
            "score": i.score
        })

    return JsonResponse({"status": "ok", "data": message})


import json
import google.generativeai as genai

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
from django.contrib.auth.models import User
from .models import Exam, QuestionScore

# Configure Gemini API
genai.configure(api_key=settings.GEMINI_API_KEY)

# Load Gemini model
model = genai.GenerativeModel("gemini-2.5-flash")




@csrf_exempt
def generate_exam(request):
    if request.method != "POST":
        return JsonResponse({"error": "POST only"}, status=405)

    prompt = """
    Generate EXACTLY 5 technical interview questions.

    Return ONLY valid JSON in this format:

    {
      "questions": [
        "Question 1",
        "Question 2",
        "Question 3",
        "Question 4",
        "Question 5"
      ]
    }

    Do not include explanations, markdown, or extra text.
    """

    try:
        response = model.generate_content(prompt)

        text = response.text.strip()
        text = text.replace("```json", "").replace("```", "").strip()

        data = json.loads(text)

        # Ensure exactly 5 questions
        questions = data.get("questions", [])[:5]

        return JsonResponse({
            "questions": questions
        })

    except Exception as e:
        return JsonResponse({
            "error": "Gemini generation failed",
            "details": str(e)
        })

from .models import user as CustomUser

@csrf_exempt
def evaluate_exam(request):
    if request.method != "POST":
        return JsonResponse({"error": "POST only"}, status=405)

    try:
        print("===== EVALUATE EXAM START =====")

        body = json.loads(request.body)
        print("Request Body:", body)

        uid = body.get("uid")
        qa_list = body.get("answers")

        if not uid or not qa_list:
            return JsonResponse({"error": "Missing uid or answers"})

        try:
            uid = int(uid)
        except:
            return JsonResponse({"error": "Invalid UID format"})

        # ✅ Correct user check (custom table)
        try:
            u = CustomUser.objects.get(id=uid)
        except CustomUser.DoesNotExist:
            return JsonResponse({"error": "User does not exist"})

        print("Custom User Found:", u.name)

        # ✅ Create exam with correct object
        exam = Exam.objects.create(USER=u)

        total_score = 0

        for index, item in enumerate(qa_list, start=1):
            question = item.get("question", "")
            answer = item.get("answer", "")

            print(f"\n--- Question {index} ---")
            print("Question:", question)
            print("Answer:", answer)

            eval_prompt = f"""
            Grade this answer out of 10.
            Return only JSON:
            {{"score": number}}

            Question: {question}
            Answer: {answer}
            """

            response = model.generate_content(eval_prompt)

            text = response.text.strip()
            text = text.replace("```json", "").replace("```", "").strip()

            print("Gemini Response:", text)

            try:
                result = json.loads(text)
                score = float(result.get("score", 0))
            except:
                score = 0

            total_score += score

            QuestionScore.objects.create(
                EXAM=exam,
                question=question,
                user_answer=answer,
                score=score
            )

        exam.total_score = total_score
        exam.save()

        print("Final Score:", total_score)

        return JsonResponse({
            "status": "ok",
            "total_score": total_score,
            "max_score": 10 * len(qa_list)
        })

    except Exception as e:
        print("❌ Evaluation Failed:", str(e))
        return JsonResponse({
            "error": "Evaluation failed",
            "details": str(e)
        })