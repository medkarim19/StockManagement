import React, { useState, useEffect } from 'react';
import { Button, Modal, Form } from 'react-bootstrap';
import { addProduct } from 'products/productApi';
import Select from 'react-select';
import { getAllProjects } from 'projects/projectApi';
import { jwtDecode } from 'jwt-decode';

const AddProductModal = ({ open, closeModal, updateProducts}) => {
  const initialFormData = {
    name: '',
    description: '',
    category: '',
    quantity: 1,
  };

  const [projects, setProjects] = useState([]);
  const [formData, setFormData] = useState(initialFormData);
  const [selectedProject, setSelectedProject] = useState(null);
  const [token, setToken] = useState(null); 

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllProjects();
        setProjects(data);
        const fetchedToken = fetchToken();
        setToken(fetchedToken);
      } catch (error) {
        console.error('Error fetching projects:', error);
      }
    };

    fetchData();
  }, []);

  const fetchToken = () => {
    const accessToken = localStorage.getItem('access_token');
    return accessToken;
  };

  const projectOptions = projects.map(project => ({
    value: project.id,
    label: project.projectName,
  }));

  const handleInputChange = e => {
    const { name, value, type } = e.target;
    const newValue = type === 'number' ? parseInt(value) : value;
    setFormData({ ...formData, [name]: newValue });
  };

  const resetFormAndCloseModal = () => {
    setFormData(initialFormData);
    closeModal();
  };

  const handleSave = async () => {
    try {
      if (typeof token !== 'string' || token === '') {
        throw new Error('Invalid token specified: must be a non-empty string');
      }
      
      const decodedToken = jwtDecode(token);
      const { user_id } = decodedToken;
      const updatedFormData = { ...formData, project_id: selectedProject.value, creator_id: user_id };
      await addProduct(updatedFormData);
      console.log('New product added successfully');
      resetFormAndCloseModal();
      if (typeof updateProducts === 'function') {
        updateProducts();
      }
    } catch (error) {
      console.error('Error adding a new product:', error);
    }
  };

  return (
    <Modal show={open} onHide={resetFormAndCloseModal} aria-labelledby="ModalHeader" centered>
      <Modal.Header closeButton>
        <Modal.Title id="ModalHeader">
          <h2>Add Product</h2>
        </Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formProductName" style={{ marginBottom: '15px' }}>
            <Form.Control
              type="text"
              placeholder="Product Name"
              name="name"
              value={formData.name}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>
          <Form.Group controlId="formDescription" style={{ marginBottom: '15px' }}>
            <Form.Control
              as="textarea"
              placeholder="Description"
              name="description"
              value={formData.description}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>
          <Form.Group controlId="formProject" style={{ marginBottom: '15px' }}>
            <Select
              options={projectOptions}
              placeholder="Projects"
              value={selectedProject}
              onChange={setSelectedProject}
            />
          </Form.Group>
          <Form.Group controlId="formCategory" style={{ marginBottom: '15px' }}>
            <Form.Control
              type="text"
              placeholder="Category"
              name="category"
              value={formData.category}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>
          <Form.Group controlId="formQuantity" style={{ marginBottom: '15px' }}>
            <Form.Control
              type="number"
              placeholder="Quantity"
              name="quantity"
              value={formData.quantity}
              onChange={handleInputChange}
              min={1}
              style={{ width: '100%' }}
            />
          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={resetFormAndCloseModal}>
          Cancel
        </Button>
        <Button variant="primary" onClick={handleSave}>
          Save
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default AddProductModal;
