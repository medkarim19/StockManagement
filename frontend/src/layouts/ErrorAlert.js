// ErrorAlert.js
import React from 'react';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const ErrorAlert = ({ message }) => {
  return (
    <div>
      {toast.error(message)}
    </div>
  );
};

export default ErrorAlert;