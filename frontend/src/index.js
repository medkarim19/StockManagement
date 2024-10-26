import React from "react";
import PrivateRoutes from 'context/PrivateRoute';
import ReactDOM from "react-dom/client";
import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import {AuthProvider} from 'context/AuthContext';
import "assets/plugins/nucleo/css/nucleo.css";
import "@fortawesome/fontawesome-free/css/all.min.css";
import "assets/scss/argon-dashboard-react.scss";
import AdminLayout from "layouts/Admin.js";
import AuthLayout from "layouts/Auth.js";


const root = ReactDOM.createRoot(document.getElementById("root"));

root.render(
  <BrowserRouter>
  <AuthProvider>
        <Routes>
          <Route path="/auth/*" element={<AuthLayout />} />
          <Route element={<PrivateRoutes/>}>
            <Route path="/admin/*" element={<AdminLayout />} />
            <Route path="*" element={<Navigate to="/admin/index" replace />} />
          </Route>
        </Routes>
  </AuthProvider>
  </BrowserRouter>
);