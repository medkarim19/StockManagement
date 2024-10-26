import React, { useState, useEffect } from 'react';
import { Button, Modal, Form } from 'react-bootstrap';
import { updateProductById, getProductById } from 'products/productApi';
import { getAllProjects } from 'projects/projectApi';
import Select from 'react-select';
import { jwtDecode } from 'jwt-decode'; 

const UpdateProductModal = ({ open, closeModal, productId, updateProducts }) => {
  const [selectedProject, setSelectedProject] = useState(null);
  const [projects, setProjects] = useState([]);
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    category: '',
    quantity: 1,
  });
  const [userId, setUserId] = useState(null); 

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllProjects();
        setProjects(data);
      } catch (error) {
        console.error('Error fetching projects:', error);
      }
    };

    fetchData();
  }, []);

  useEffect(() => {
    const fetchProductDetails = async () => {
      try {
        const product = await getProductById(productId);
        setFormData({
          name: product.name,
          description: product.description,
          category: product.category,
          quantity: product.quantity,
        });
        setSelectedProject({ value: product.project_id, label: product.project_name });
      } catch (error) {
        console.error('Error fetching product details:', error);
      }
    };

    if (open && productId) {
      fetchProductDetails();
    }
  }, [open, productId]);

  useEffect(() => {
    const accessToken = localStorage.getItem('access_token');
    if (accessToken) {
      const decodedToken = jwtDecode(accessToken);
      const { user_id } = decodedToken;
      setUserId(user_id);
    }
  }, []);

  const resetFormAndCloseModal = () => {
    setFormData({
      name: '',
      description: '',
      category: '',
      quantity: 1,
    });
    setSelectedProject(null);
    closeModal();
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevState => ({
      ...prevState,
      [name]: value,
    }));
  };

  const handleUpdate = async () => {
    try {
      const updateData = {
        ...formData,
        project_id: selectedProject?.value,
        user_id: userId, 
      };
      await updateProductById(productId, updateData);
      console.log('Product updated successfully');
      resetFormAndCloseModal();
      if (typeof updateProducts === 'function') {
        updateProducts();
      }
    } catch (error) {
      console.error('Error updating product:', error);
    }
  };

  const projectOptions = projects.map(project => ({
    value: project.id,
    label: project.projectName,
  }));

  return (
    <Modal show={open} onHide={resetFormAndCloseModal} aria-labelledby="UpdateModalHeader" centered>
      <Modal.Header closeButton>
        <Modal.Title id='UpdateModalHeader'><h2>Edit Product</h2></Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formName" style={{ marginBottom: '15px' }}>
            <Form.Label>Product name:</Form.Label>
            <Form.Control
              type="text"
              placeholder="product name"
              name="name"
              value={formData.name}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>

          <Form.Group controlId="formDescription" style={{ marginBottom: '15px' }}>
            <Form.Label>Description:</Form.Label>
            <Form.Control
              as="textarea"
              placeholder="description"
              name="description"
              value={formData.description}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>

          <Form.Group controlId="formCategory" style={{ marginBottom: '15px' }}>
            <Form.Label>Category:</Form.Label>
            <Form.Control
              type="text"
              placeholder="category"
              name="category"
              value={formData.category}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>

          <Form.Group controlId="formProjects" style={{ marginBottom: '15px' }}>
            <Select
              options={projectOptions}
              placeholder="Projects"
              value={selectedProject}
              onChange={setSelectedProject}
            />
          </Form.Group>

          <Form.Group controlId="formQuantity" style={{ marginBottom: '15px' }}>
            <Form.Label>Quantity:</Form.Label>
            <Form.Control
              type="number"
              placeholder="Quantity"
              name="quantity"
              value={formData.quantity}
              onChange={handleInputChange}
              min={1} // Setting minimum value to 1
              style={{ width: '100%' }}
            />
          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant='secondary' onClick={resetFormAndCloseModal}>
          Cancel
        </Button>
        <Button variant='primary' onClick={handleUpdate}>
          Update
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default UpdateProductModal;
