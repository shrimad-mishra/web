from django.db import models

# Create your models here.

class ProductDetals(models.Model):

    product_name = models.CharField(default="bag", max_length=50)

    product_description = models.TextField(default="Importance of description")
