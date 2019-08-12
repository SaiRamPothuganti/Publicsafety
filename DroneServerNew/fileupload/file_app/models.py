# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.
from django.db import models

class File(models.Model):

  remark = models.CharField(max_length=100)
  timestamp = models.DateTimeField(auto_now_add=True)