import Index from "components/Index";
import Profile from "components/Profile";
import Login from "components/Login";
import Users from "users/Users";
import Project from "components/Project";
import Product from "components/Products";
import CreateNewAccount from "staffaccount/CreateNewAccount";
import BackupRestoreComponent from "components/Settings";
import { checkIsStaffStatus } from "users/userApi";
import Order from "components/Orders";
const isAdmin = await checkIsStaffStatus();


var routes = [
  {
    path: "/index",
    name: "Dashboard",
    icon: "ni ni-tv-2 text-primary",
    component: isAdmin ? <Index /> : <Product />,
    layout: "/admin",
  },
  {
    path: "/user-profile",
    name: "Profile",
    icon: "ni ni-single-02 text-yellow",
    component: <Profile />,
    layout: "/admin",
  },
  {
    path: "/settings",
    name: "Settings",
    icon: "ni ni-single-02 text-yellow",
    component: <BackupRestoreComponent />,
    layout: "/admin",
  },
  {
    path: "/users",
    name: "Users",
    icon: "ni ni-single-02 text-yellow",
    component: <Users />,
    layout: "/admin",
    superuserOnly: true,
  },
  {
    path: "/login",
    name: "Login",
    icon: "ni ni-key-25 text-info",
    component: <Login />,
    layout: "/auth",
  },
  {
    path: "/create",
    name: "Create Account",
    icon: "ni ni-single-02 text-green",
    component: <CreateNewAccount />,
    layout: "/auth",
  },
  {
    path: "/projects",
    name: "Projects",
    icon: "fa-solid fa-box",
    component: <Project />,
    layout: "/admin",
  },
  {
    path: "/products",
    name: "Products",
    icon: "fa-brands fa-codepen text-green",
    component: <Product />,
    layout: "/admin",
  },
  {
    path: "/orders",
    name: "Orders",
    icon: "fa-solid fa-list text-red",
    component: <Order />,
    layout: "/admin",
  },
  
];
export default routes;