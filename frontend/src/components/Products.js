import React, { useState, useEffect } from "react";
import {
  Card,
  Form,
  FormGroup,
  Input,
  InputGroup,
  InputGroupText,
  InputGroupAddon,
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
import Header from "components/Headers/Header.js";
import { getAllProjects, deleteProductById, getAllProducts } from "../products/productApi";
import { checkIsStaffStatus } from "users/userApi"; // Importing checkIsStaffStatus function
import "../assets/css/sweetAlertStyle.css";
import Swal from 'sweetalert2';
import AddProductModal from "./Modals/AddProductModal";
import UpdateProductModal from "./Modals/UpdateProductModal";
import { isConstructorDeclaration } from "typescript";

const DeleteConfirmationModal = ({ isOpen, toggle, onDelete }) => {
  return (
    <Modal isOpen={isOpen} toggle={toggle}>
      <ModalHeader toggle={toggle}>Delete Confirmation</ModalHeader>
      <ModalBody>
        Are you sure you want to delete this product?
      </ModalBody>
      <ModalFooter>
        <Button color="danger" onClick={onDelete}>Delete</Button>{' '}
        <Button color="secondary" onClick={toggle}>Cancel</Button>
      </ModalFooter>
    </Modal>
  );
};

const Product = () => {
  const [projects, setProjects] = useState([]);
  const [products, setProducts] = useState([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isUpdateModalOpen, setIsUpdateModalOpen] = useState(false);
  const [selectedProductId, setSelectedProductId] = useState(null);
  const [selectedProjectId, setSelectedProjectId] = useState(null);
  const [isDeleteModalOpen, setIsDeleteModalOpen] = useState(false);
  const [deleteProductId, setDeleteProductId] = useState(null);
  const [isStaff, setIsStaff] = useState(false); // State to store staff status
  const [searchQuery, setSearchQuery] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const productsPerPage = 5;

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllProjects();
        setProjects(data);
      } catch (error) {
        
      }
    };

    fetchData();
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllProducts();
        setProducts(data);
      } catch (error) {
        
      }
    };

    fetchData();

    // Check if the user is staff when component mounts
    const checkStaffStatus = async () => {
      const isStaff = await checkIsStaffStatus();
      setIsStaff(isStaff);
    };
    checkStaffStatus();
  }, []);

  const handleDelete = async (productId) => {
    setDeleteProductId(productId);
    setIsDeleteModalOpen(true);
  };

  const updateProducts = async () => {
    try {
      const data = await getAllProducts();
      setProducts(data);
    } catch (error) {
      
    }
  };
  
  const handleUpdate = (productId) => {
    setSelectedProductId(productId);  
    setIsUpdateModalOpen(true); 
  };

  const confirmDelete = async () => {
    try {
      const response = await deleteProductById(deleteProductId);
      Swal.fire({
        icon: 'success',
        title: 'Success',
        text: `Product with ID ${deleteProductId} deleted successfully`,
        customClass: {
          container: 'custom-swal-container'
        }
      });
      setProducts((prevProducts) => prevProducts.filter((product) => product.id !== deleteProductId));
    } catch (error) {
      
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

  const handleSearchChange = (e) => {
    setSearchQuery(e.target.value);
  };

  const filteredProducts = products.filter((product) =>
    product.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  // Logic to calculate pagination
  const indexOfLastProduct = currentPage * productsPerPage;
  const indexOfFirstProduct = indexOfLastProduct - productsPerPage;
  const currentProducts = filteredProducts.slice(indexOfFirstProduct, indexOfLastProduct);

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
                    <Form className="navbar-search navbar-search-dark form-inline mr-3 d-none d-md-flex ml-lg-auto">
                      <FormGroup className="mb-0">
                        <InputGroup className="input-group-alternative" style={{ backgroundColor: 'transparent', borderColor: '#5e72e4', }}>
                          <InputGroupAddon addonType="prepend">
                            <InputGroupText style={{ color: '#5e72e4' }} >
                              <i className="fas fa-search" />
                            </InputGroupText>
                          </InputGroupAddon>
                          <Input type="text" style={{ color: '#5e72e4' }} value={searchQuery} onChange={handleSearchChange} placeholder="Search" />
                        </InputGroup>
                      </FormGroup>
                    </Form>
                  </Col>
                  <Col className="text-right" xs="4">
                    {isStaff && ( // Render "Add Product" button only if the user is staff
                      <Button color="primary" onClick={() => openModal()}>
                        Add Product
                      </Button>
                    )}
                  </Col>
                </Row>
              </CardHeader>
              <Table className="align-items-center table-flush" responsive>
                <thead className="thead-light">
                  <tr>
                    <th scope="col">Product ID</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Description</th>
                    {isStaff && <th scope="col">Current Project Name</th>}
                    {isStaff && <th scope="col">Previous Project Name</th>}
                    {isStaff && <th scope="col">Change Date</th>}
                    {isStaff && <th scope="col">Creator</th>}
                    {isStaff && <th scope="col">Modifier</th>}
                    <th scope="col">Quantity</th>
                    {isStaff && <th scope="col">Actions</th>} {/* Render "Actions" column only if the user is staff */}
                    <th scope="col" />
                  </tr>
                </thead>
                <tbody>
                  {Array.isArray(currentProducts) && currentProducts.map((product) => (
                    <tr key={product.id}>
                      <td>{product.id}</td>
                      <td>{product.name}</td>
                      <td>{product.description ? product.description : "No description Update it"}</td>
                      {isStaff && (
                        <>
                          <td>
                            <input type="hidden" value={product.project_id} />
                            {projects.find(project => project.id === product.project_id)?.projectName || "Unknown"}
                          </td>
                          <td>
                            <input type="hidden" value={product.previous_project_id} />
                            {projects.find(project => project.id === product.previous_project_id)?.projectName || "No changes"}
                          </td>
                          <td>{product.change_date ? product.change_date.split('.')[0] : "No change detected"}</td>
                          <td>{product.creator_username}</td>
                          <td>{product.modifier_username ? product.modifier_username : "Null"}</td>
                        </>
                      )}
                      <td>{product.quantity}</td>
                      {isStaff && ( // Render "Actions" column only if the user is staff
                        <td>
                          <span
                            onClick={() => handleUpdate(product.id)}
                            className="mr-3"
                            style={{ cursor: "pointer", color: "green" }}
                          >
                            <i className="fas fa-edit"></i>
                          </span>
                          <span style={{ cursor: "pointer", color: "red" }} onClick={() => handleDelete(product.id)}>
                            <i className="fas fa-trash-alt"></i>
                          </span>{" "}
                        </td>
                      )}
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
                    {[...Array(Math.ceil(filteredProducts.length / productsPerPage)).keys()].map((number) => (
                      <PaginationItem key={number} className={number + 1 === currentPage ? "active" : ""}>
                        <PaginationLink onClick={() => paginate(number + 1)} href="#">
                          {number + 1}
                        </PaginationLink>
                      </PaginationItem>
                    ))}
                    <PaginationItem className={currentPage === Math.ceil(filteredProducts.length / productsPerPage) ? "disabled" : ""}>
                      <PaginationLink next href="#" onClick={() => paginate(currentPage + 1)} />
                    </PaginationItem>
                  </Pagination>
                </nav>
              </CardFooter>
            </Card>
          </div>
        </Row>
      </Container>
      <AddProductModal open={isModalOpen} closeModal={closeModal} updateProducts={updateProducts} />
      <UpdateProductModal open={isUpdateModalOpen} closeModal={() => setIsUpdateModalOpen(false)} updateProducts={updateProducts} productId={selectedProductId} />
      <DeleteConfirmationModal isOpen={isDeleteModalOpen} toggle={toggleDeleteModal} onDelete={confirmDelete} />
    </>
  );
};

export default Product;
