import React from 'react';
import { useAuth } from './AuthContext';
import { Outlet, Navigate } from 'react-router-dom';

const PrivateRoutes = () => {
  const { isLoggedIn } = useAuth();
  return isLoggedIn ? <Outlet /> : <Navigate to="/auth/login" />;
};

export default PrivateRoutes;