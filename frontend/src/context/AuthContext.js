// authContext.js

import React, { createContext, useContext, useState, useEffect } from 'react';
import axiosInstance from 'axiosApi';
import { useNavigate } from 'react-router-dom';

const AuthContext = createContext();

export function useAuth() {
  return useContext(AuthContext);
}

export const AuthProvider = ({ children }) => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [loading, setLoading] = useState(true);
  const [currentUser, setCurrentUser] = useState(null); // Add currentUser state
  const navigate = useNavigate();

  const login = async (email, password) => {
    try {
      const response = await axiosInstance.post('/login/', {
        email,
        password,
      });

      const { access, refresh } = response.data;

      localStorage.setItem('access_token', access);
      localStorage.setItem('refresh_token', refresh);
      axiosInstance.defaults.headers['Authorization'] = "Bearer " + access;

      // Fetch user details after successful login
      const userResponse = await axiosInstance.get('users/details/');
      const user = userResponse.data;

      setCurrentUser(user);
      setIsLoggedIn(true);
      navigate("/admin/index");
    } catch (error) {
      throw error;
    }
  };

  const logout = () => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
    setIsLoggedIn(false);
    setCurrentUser(null); // Clear currentUser on logout
    delete axiosInstance.defaults.headers['Authorization'];
    navigate("/auth/login");
  };

  useEffect(() => {
    const initializeAuth = async () => {
      const accessToken = localStorage.getItem('access_token');
      const refreshToken = localStorage.getItem('refresh_token');
      const isAuthenticated = !!accessToken && !!refreshToken;
      setIsLoggedIn(isAuthenticated);

      if (isAuthenticated) {
        // Fetch user details if authenticated
        const userResponse = await axiosInstance.get('users/details/');
        const user = userResponse.data;
        setCurrentUser(user);
      }

      setLoading(false);
    };

    initializeAuth();
  }, []);

  const value = {
    isLoggedIn,
    currentUser,
    login,
    logout,
  };

  return (
    <AuthContext.Provider value={value}>
      {!loading && children}
    </AuthContext.Provider>
  );
};