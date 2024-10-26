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
import AddProjectModal from "components/Modals/AddProjectModal";
import Header from "components/Headers/Header.js";
import { checkIsStaffStatus } from "users/userApi"; 
import { getAllProjects, deleteProjectById } from "../projects/projectApi";
import "../assets/css/sweetAlertStyle.css";
import Swal from 'sweetalert2';

const DeleteConfirmationModal = ({ isOpen, toggle, onDelete }) => {
  return (
    <Modal isOpen={isOpen} toggle={toggle}>
      <ModalHeader toggle={toggle}>Delete Confirmation</ModalHeader>
      <ModalBody>
        Are you sure you want to delete this project?
      </ModalBody>
      <ModalFooter>
        <Button color="danger" onClick={onDelete}>Delete</Button>{' '}
        <Button color="secondary" onClick={toggle}>Cancel</Button>
      </ModalFooter>
    </Modal>
  );
};

const Project = () => {
  const [projects, setProjects] = useState([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedProjectId, setSelectedProjectId] = useState(null);
  const [isDeleteModalOpen, setIsDeleteModalOpen] = useState(false);
  const [deleteProjectId, setDeleteProjectId] = useState(null);
  const [isStaff, setIsStaff] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const projectsPerPage = 5;

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllProjects();
        setProjects(data);
      } catch (error) {
        
      }
    };

    fetchData();

    const checkStaffStatus = async () => {
      const isStaff = await checkIsStaffStatus();
      setIsStaff(isStaff);
    };
    checkStaffStatus();
  }, []);


  const updateProjects = async () => {
    try {
      const data = await getAllProjects();
      setProjects(data);
    } catch (error) {
      
    }
  };
 
  const handleDelete = async (projectId) => {
    setDeleteProjectId(projectId);
    setIsDeleteModalOpen(true);
  };

  const confirmDelete = async () => {
    try {
      const response = await deleteProjectById(deleteProjectId);
      Swal.fire({
        icon: 'success',
        title: 'Success',
        text: `Project with ID ${deleteProjectId} deleted successfully`,
        customClass: {
          container: 'custom-swal-container'
        }
      });
      setProjects((prevProjects) => prevProjects.filter((project) => project.id !== deleteProjectId));
    } catch (error) {
      console.error(`Error deleting project with ID ${deleteProjectId}:`, error);
    }
    setIsDeleteModalOpen(false);
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

  // Logic to calculate pagination
  const indexOfLastProject = currentPage * projectsPerPage;
  const indexOfFirstProject = indexOfLastProject - projectsPerPage;
  const currentProjects = projects.slice(indexOfFirstProject, indexOfLastProject);

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
                    <h3 className="mb-0">Projects</h3>
                  </Col>
                  { isStaff && <Col className="text-right" xs="4">
                    <Button color="primary" onClick={() => openModal()}>
                      Add Project
                    </Button>
                  </Col> }
                </Row>
              </CardHeader>
              <Table className="align-items-center table-flush" responsive>
                <thead className="thead-light">
                  <tr>
                    <th scope="col">Project ID</th>
                    <th scope="col">Project Name</th>
                    <th scope="col">Description</th>
                    {isStaff &&  <th scope="col">Actions</th> }
                    <th scope="col" />
                  </tr>
                </thead>
                <tbody>
                  {Array.isArray(currentProjects) && currentProjects.map((project) => (
                    <tr key={project.id}>
                      <td>{project.id}</td>
                      <td>{project.projectName}</td>
                      <td>{project.description}</td>
                      
                        {isStaff && 
                        <td>
                        <span
                          onClick={() => handleDelete(project.id)}
                          style={{ cursor: "pointer", color: "red" }}
                        >
                          <i className="fas fa-trash-alt"></i>
                        </span>{" "}
                      </td>
                        }
                      <td />
                    </tr>
                  ))}
                </tbody>
              </Table>
              <CardFooter className="py-4">
                <nav aria-label="...">
                  <Pagination className="pagination justify-content-end mb-0" listClassName="justify-content-end mb-0">
                    <PaginationItem className="disabled">
                      <PaginationLink previous href="#" onClick={() => paginate(currentPage - 1)} />
                    </PaginationItem>
                    {[...Array(Math.ceil(projects.length / projectsPerPage)).keys()].map((number) => (
                      <PaginationItem key={number} className={number + 1 === currentPage ? "active" : ""}>
                        <PaginationLink onClick={() => paginate(number + 1)} href="#">
                          {number + 1}
                        </PaginationLink>
                      </PaginationItem>
                    ))}
                    <PaginationItem className={currentPage === Math.ceil(projects.length / projectsPerPage) ? "disabled" : ""}>
                      <PaginationLink next href="#" onClick={() => paginate(currentPage + 1)} />
                    </PaginationItem>
                  </Pagination>
                </nav>
              </CardFooter>
            </Card>
          </div>
        </Row>
      </Container>
      <AddProjectModal open={isModalOpen} closeModal={closeModal} updateProjects={updateProjects} />
      <DeleteConfirmationModal isOpen={isDeleteModalOpen} toggle={toggleDeleteModal} onDelete={confirmDelete} />
    </>
  );
};

export default Project;
