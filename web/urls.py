from django.contrib import admin
from django.urls import path, include
from web.views import *


urlpatterns = [
    path('save', save_post),
    path('home', home),
    path('', index),
    path('health', health_check)
]
