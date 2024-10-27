import json
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render
from web.models import ProductDetals


def home(request):
    products = ProductDetals.objects.all()
    return render(request, 'home.html', {'products': products})


def index(request):
    return render(request, 'index.html')


def save_post(request):
    if request.method == "POST":
        try:
   
            data = json.loads(request.body.decode("utf-8"))

            ProductDetals.objects.create(
                product_name=data["name"], 
                product_description=data["description"]
            )

            return JsonResponse({"status": 200, "message": "success"})

        except Exception as e:
            return JsonResponse({"status": 500, "message": str(e)})
    
    return JsonResponse({"status": 405, "message": "Method not allowed"})


def health_check(request):
   return HttpResponse("OK", status=200)
