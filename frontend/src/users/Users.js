import React, { useState, useEffect } from "react";
import {
  Card,
  CardHeader,
  CardFooter,
  Pagination,
  PaginationItem,
  PaginationLink,
  Table,
  Container,
  Row,
  Col,
  Button,
  Modal,
  ModalHeader,
  ModalBody,
  ModalFooter
} from "reactstrap";
import AddModalComponent from "components/Modals/AddModalComponent";
import UpdateModalComponent from "components/Modals/UpdateModalComponent";
import Header from "components/Headers/Header.js";
import { getAllUsers, deleteUserById, checkIsStaffStatus, checkSuperuserStatus } from "users/userApi";
import "../assets/css/sweetAlertStyle.css";
import Swal from 'sweetalert2';
import Forbidden from "errors/Forbidden";

const DeleteConfirmationModal = ({ isOpen, toggle, onDelete }) => {
  return (
    <Modal isOpen={isOpen} toggle={toggle}>
      <ModalHeader toggle={toggle}>Delete Confirmation</ModalHeader>
      <ModalBody>
        Are you sure you want to delete this user?
      </ModalBody>
      <ModalFooter>
        <Button color="danger" onClick={onDelete}>Delete</Button>{' '}
        <Button color="secondary" onClick={toggle}>Cancel</Button>
      </ModalFooter>
    </Modal>
  );
};

const Users = () => {
  const [users, setUsers] = useState([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isUpdateModalOpen, setIsUpdateModalOpen] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState(null);
  const [isDeleteModalOpen, setIsDeleteModalOpen] = useState(false);
  const [deleteUserId, setDeleteUserId] = useState(null);
  const [forbidden, setForbidden] = useState(false);
  const [isStaff, setIsStaff] = useState(false); // State for is_staff status
  const [isSuperuser, setIsSuperuser] = useState(false); // State for is_superuser status
  const [currentPage, setCurrentPage] = useState(1);
  const usersPerPage = 5;

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllUsers();
        if (data === false) {
          setForbidden(true);
        } else {
          setUsers(data);
        }
      } catch (error) {
        console.error('Error fetching users:', error);
      }
    };

    fetchData();

    // Fetch and set is_staff and is_superuser status
    const fetchStatus = async () => {
      try {
        const isStaffStatus = await checkIsStaffStatus();
        const isSuperuserStatus = await checkSuperuserStatus();
        setIsStaff(isStaffStatus);
        setIsSuperuser(isSuperuserStatus);
      } catch (error) {
        console.error('Error fetching status:', error);
      }
    };

    fetchStatus();
  }, []);

  const updateUsers = async () => {
    try {
      const data = await getAllUsers();
      setUsers(data);
    } catch (error) {
      console.error('Error fetching users:', error);
    }
  };

  const handleDelete = async (userId) => {
    setDeleteUserId(userId);
    setIsDeleteModalOpen(true);
  };

  const confirmDelete = async () => {
    try {
      const response = await deleteUserById(deleteUserId);
      Swal.fire({
        icon: 'success',
        title: 'Success',
        text: `User with ID ${deleteUserId} deleted successfully`,
        customClass: {
          container: 'custom-swal-container'
        }
      });
      setUsers((prevUsers) => prevUsers.filter((user) => user.id !== deleteUserId));
    } catch (error) {
      console.error(`Error deleting user with ID ${deleteUserId}:`, error);
    }
    setIsDeleteModalOpen(false);
  };

  const handleUpdate = (userId) => {
    setSelectedUserId(userId);  
    setIsUpdateModalOpen(true); 
  };

  const getUserRole = (user) => {
    if (user.is_superuser) {
        return "Super User";
    } else if (user.is_staff) {
        return "Staff User";
    } else {
        return "Regular User";
    }
  };

  const mapPermissionToAction = (permissionLevel) => {
    if (permissionLevel === 'Editor') {
        return 'Create, Update, Delete';
    } else if (permissionLevel === 'Refine') {
        return 'Create, Update';
    } else if (permissionLevel === 'Edit') {
        return 'Create, Delete';
    } else if (permissionLevel === 'Emend') {
        return 'Update, Delete';
    } else if (permissionLevel === 'Create') {
        return 'Create';
    } else if (permissionLevel === 'Modify') {
        return 'Update';
    } else if (permissionLevel === 'Delete') {
        return 'Delete';
    } else if (permissionLevel === 'Viewer' ) {
        return 'Viewer';
    } else {
      return 'Admin';
    }
  };

  const openModal = () => {
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
  };

  const toggleDeleteModal = () => {
    setIsDeleteModalOpen(!isDeleteModalOpen);
  };

  if (forbidden) {
    return (
      <>
        <Header />
        <Forbidden />
      </>
    );
  }

  // Logic to calculate pagination
  const indexOfLastUser = currentPage * usersPerPage;
  const indexOfFirstUser = indexOfLastUser - usersPerPage;
  const currentUsers = users.slice(indexOfFirstUser, indexOfLastUser);

  const paginate = (pageNumber) => setCurrentPage(pageNumber);

  return (
    <>
      <Header />
      <Container className="mt--7" fluid>
        <Row>
          <div className="col">
            <Card className="shadow">
              <CardHeader className="border-0">
                <Row className="align-items-center">
                  <Col xs="8">
                    <h3 className="mb-0">Users</h3>
                  </Col>
                  <Col className="text-right" xs="4">
                    <Button color="primary" style={{ opacity: isStaff && !isSuperuser ? 0.3 : 1 }} onClick={() => openModal()}>
                      Add User
                    </Button>
                  </Col>
                </Row>
              </CardHeader>
              <Table className="align-items-center table-flush" responsive>
                <thead className="thead-light">
                  <tr>
                    <th scope="col">User ID</th>
                    <th scope="col">Username</th>
                    <th scope="col">Email</th>
                    <th scope="col">Role</th>
                    <th scope="col">Permission Level</th>
                    <th scope="col">Actions</th>
                    <th scope="col" />
                  </tr>
                </thead>
                <tbody>
                  {Array.isArray(currentUsers) && currentUsers.map((user) => (
                    <tr key={user.id}>
                      <td>{user.id}</td>
                      <td>{user.username}</td>
                      <td>{user.email}</td>
                      <td>{getUserRole(user)}</td>
                      <td>
                        {mapPermissionToAction(user.permission_level)}
                      </td>
                      <td>
                        <span
                          onClick={() => handleUpdate(user.id)}
                          className="mr-3"
                          style={{ cursor: "pointer", color: "green", opacity: isStaff && !isSuperuser ? 0.3 : 1 }}
                        >
                          <i className="fas fa-edit"></i>
                        </span>
                        <span
                          onClick={() => handleDelete(user.id)}
                          style={{ cursor: "pointer", color: "red", opacity: isStaff && !isSuperuser ? 0.3 : 1 }}
                        >
                          <i className="fas fa-trash-alt"></i>
                        </span>
                      </td>
                      <td />
                    </tr>
                  ))}
                </tbody>
              </Table>
              <CardFooter className="py-4">
                <nav aria-label="...">
                  <Pagination className="pagination justify-content-end mb-0" listClassName="justify-content-end mb-0">
                    <PaginationItem className={currentPage === 1 ? "disabled" : ""}>
                      <PaginationLink previous href="#" onClick={() => paginate(currentPage - 1)} />
                    </PaginationItem>
                    {[...Array(Math.ceil(users.length / usersPerPage)).keys()].map((number) => (
                      <PaginationItem key={number} className={number + 1 === currentPage ? "active" : ""}>
                        <PaginationLink onClick={() => paginate(number + 1)} href="#">
                          {number + 1}
                        </PaginationLink>
                      </PaginationItem>
                    ))}
                    <PaginationItem className={currentPage === Math.ceil(users.length / usersPerPage) ? "disabled" : ""}>
                      <PaginationLink next href="#" onClick={() => paginate(currentPage + 1)} />
                    </PaginationItem>
                  </Pagination>
                </nav>
              </CardFooter>
            </Card>
          </div>
        </Row>
      </Container>
      <AddModalComponent open={isModalOpen} closeModal={closeModal} updateUsers={updateUsers} />
      <UpdateModalComponent open={isUpdateModalOpen} closeModal={() => setIsUpdateModalOpen(false)} updateUsers={updateUsers} userId={selectedUserId} />
      <DeleteConfirmationModal isOpen={isDeleteModalOpen} toggle={toggleDeleteModal} onDelete={confirmDelete} />
    </>
  );
};

export default Users;
