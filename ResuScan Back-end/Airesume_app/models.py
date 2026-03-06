from django.contrib.auth.models import User
from django.db import models



# Create your models here.
class company(models.Model):
    name=models.CharField(max_length=100)
    place=models.CharField(max_length=100)
    email=models.CharField(max_length=100)
    phone=models.CharField(max_length=100)
    latitude=models.CharField(max_length=100)
    longitude=models.CharField(max_length=100)
    status=models.CharField(max_length=100)
    LOGIN=models.ForeignKey(User,on_delete=models.CASCADE)

class user(models.Model):
    name=models.CharField(max_length=100)
    place=models.CharField(max_length=100)
    pin=models.CharField(max_length=100)
    post=models.CharField(max_length=100)
    email=models.CharField(max_length=100)
    phone=models.CharField(max_length=100)
    LOGIN=models.ForeignKey(User,on_delete=models.CASCADE)

class complaintss(models.Model):
    complaints=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    reply=models.CharField(max_length=100)
    reply_date=models.CharField(max_length=200)
    USER=models.ForeignKey(user,on_delete=models.CASCADE)

class feedback(models.Model):
    message=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    USER=models.ForeignKey(user,on_delete=models.CASCADE)

class review(models.Model):
    reviews=models.CharField(max_length=100)
    rating=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    USER=models.ForeignKey(user,on_delete=models.CASCADE)
    COMPANY=models.ForeignKey(company,on_delete=models.CASCADE)

class vaccancy(models.Model):
    job_title=models.CharField(max_length=100)
    description=models.CharField(max_length=100)
    skills=models.CharField(max_length=100)
    experience=models.CharField(max_length=100)
    salary_range=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    status=models.CharField(max_length=100)
    from_date=models.CharField(max_length=100)
    to_date=models.CharField(max_length=100)
    COMPANY=models.ForeignKey(company,on_delete=models.CASCADE)


class vaccancy_request(models.Model):
    resume=models.CharField(max_length=100)
    status=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    interview_date=models.CharField(max_length=100)
    interview_time=models.CharField(max_length=100)
    schedule=models.CharField(max_length=100)
    VACCANCY=models.ForeignKey(vaccancy,on_delete=models.CASCADE)
    USER=models.ForeignKey(user,on_delete=models.CASCADE)


class exam_schedule(models.Model):
    date=models.CharField(max_length=100)
    time=models.CharField(max_length=100)
    venue=models.CharField(max_length=100)
    VACANCY_REQUEST=models.ForeignKey(vaccancy_request,on_delete=models.CASCADE)

class question(models.Model):
    questions=models.CharField(max_length=100)
    option_a=models.CharField(max_length=100)
    option_b=models.CharField(max_length=100)
    option_c=models.CharField(max_length=100)
    option_d=models.CharField(max_length=100)
    corrected_answer=models.CharField(max_length=100)
    EXAM_SCHEDULEE=models.ForeignKey(exam_schedule,on_delete=models.CASCADE)




class exam_result(models.Model):
    score=models.CharField(max_length=100)
    VACANCY_REQUEST=models.ForeignKey(vaccancy_request,on_delete=models.CASCADE)
    QUESTION=models.ForeignKey(question,on_delete=models.CASCADE)



class Exam(models.Model):
    USER = models.ForeignKey(user, on_delete=models.CASCADE)
    total_score = models.FloatField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)


class QuestionScore(models.Model):
    EXAM = models.ForeignKey(Exam, on_delete=models.CASCADE)
    question = models.TextField()
    user_answer = models.TextField()
    score = models.FloatField(default=0)







