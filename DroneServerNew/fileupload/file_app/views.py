# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render

# Create your views here.
from rest_framework.views import APIView
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from rest_framework import status

from .serializers import FileSerializer
import os
class FileView(APIView):

  parser_classes = (MultiPartParser, FormParser)

  def post(self, request, *args, **kwargs):

    file_serializer = FileSerializer(data=request.data)
    if file_serializer.is_valid():
      file_serializer.save()
      #os.system("C:\Python27\python.exe C:\Tello\sdk\Tello-Python-master\Tello-Python-master\TelloToFire.py")
      os.system("sh c:\\run.sh")
      return Response(file_serializer.data, status=status.HTTP_201_CREATED)
    else:
      return Response(file_serializer.errors, status=status.HTTP_400_BAD_REQUEST)