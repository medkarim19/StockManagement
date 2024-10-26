import React from 'react';
import { Link } from 'react-router-dom';
import {
  DropdownMenu,
  DropdownItem,
  UncontrolledDropdown,
  DropdownToggle,
  Navbar,
  Nav,
  Container
} from "reactstrap";

import { Media } from 'reactstrap';
import { useAuth } from 'context/AuthContext';

const AdminNavbar = (props) => {
  const { logout, isLoggedIn, currentUser } = useAuth();

  const handleLogout = async () => {
    try {
      await logout();
    } catch (e) {
      
    }
  };
  
  return (
    <>
      <Navbar className="navbar-top navbar-dark" expand="md" id="navbar-main">
        <Container fluid>
          <Link className="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" to="/">
            {props.brandText}
          </Link>
          <Nav className="align-items-center d-none d-md-flex" navbar>
            {isLoggedIn && currentUser ? (
              <UncontrolledDropdown nav>
                <DropdownToggle nav>
                  <Media className="align-items-center">
                    <span className="avatar avatar-sm rounded-circle">
                      <img
                        alt="..."
                        src="https://t4.ftcdn.net/jpg/03/31/69/91/360_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg"
                      />
                    </span>
                    <Media className="ml-2 d-none d-lg-block">
                      <Link className="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block">
                        {currentUser.username}
                      </Link>
                    </Media>
                  </Media>
                </DropdownToggle>
                <DropdownMenu className="dropdown-menu-arrow" right>
                  {/* User menu items */}
                  <DropdownItem className="noti-title" header tag="div">
                    <h6 className="text-overflow m-0">Welcome!</h6>
                  </DropdownItem>
                  <DropdownItem to="/admin/user-profile" tag={Link}>
                    <i className="ni ni-single-02" />
                    <span>My profile</span>
                  </DropdownItem>
                  <DropdownItem to="/admin/settings" tag={Link}>
                    <i className="ni ni-settings-gear-65" />
                    <span>Settings</span>
                  </DropdownItem>
                  <DropdownItem href="#pablo" onClick={(e) => {
                    e.preventDefault();
                    handleLogout();
                  }}>
                    <i className="ni ni-user-run" />
                    <span>Logout</span>
                  </DropdownItem>
                </DropdownMenu>
              </UncontrolledDropdown>
            ) : null}
          </Nav>
        </Container>
      </Navbar>
    </>
  );
};

export default AdminNavbar;