// src/lib/axios.ts
import axios from 'axios';

const axiosInstance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_BASE_URL,
  timeout: 5000, // 5초 타임아웃
  headers: {
    'Content-Type': 'application/json',
  },
});

export default axiosInstance;