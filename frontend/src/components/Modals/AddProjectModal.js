import React, { useState } from 'react';
import { Button, Modal, Form } from 'react-bootstrap';
import { addProject } from 'projects/projectApi';
import Swal from 'sweetalert2';

const AddProjectModal = ({ open, closeModal, updateProjects }) => {
  const initialFormData = {
    projectName: '',
    description: '',
    supplierName: '',
    orderItems: [{ productName: '', quantity: 1 }],
  };

  const [formData, setFormData] = useState(initialFormData);
  const [showRemoveButton, setShowRemoveButton] = useState(false);

  const handleInputChange = (e, index) => {
    const { name, value } = e.target;
    if (name === 'productName' || name === 'quantity') {
      const updatedOrderItems = [...formData.orderItems];
      updatedOrderItems[index][name] = value;
      setFormData({ ...formData, orderItems: updatedOrderItems });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const resetFormAndCloseModal = () => {
    setFormData(initialFormData);
    closeModal();
  };

  const handleSave = async () => {
    const isProductNameEmpty = formData.orderItems.some(item => item.productName.trim() === '');

    if (isProductNameEmpty) {
      console.error('Please provide a product name for all items');
      return;
    }

    try {
      await addProject(formData);
      console.log('New project added successfully');
      resetFormAndCloseModal();
      if (typeof updateProjects === 'function') {
        updateProjects();
      }
    } catch (error) {
      console.error('Error adding a new project:', error);
    }
  };

  const addOrderItem = () => {
    const lastIndex = formData.orderItems.length - 1;
    if (lastIndex >= 0 && formData.orderItems[lastIndex].productName.trim() === '') {
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'You must provide a product name for the last product!',
        customClass: {
          container: 'custom-swal-container'
        }
      });
      return false;
    }

    setFormData({
      ...formData,
      orderItems: [...formData.orderItems, { productName: '', quantity: 1 }],
    });

    setShowRemoveButton(true);
  };

  const removeLastOrderItem = () => {
    // Check if there is more than one product before removing the last one
    if (formData.orderItems.length > 1) {
      const updatedOrderItems = [...formData.orderItems];
      updatedOrderItems.pop();
      setFormData({
        ...formData,
        orderItems: updatedOrderItems,
      });
  
      // Hide the Remove Last Product button if there are no items left after removal
      if (updatedOrderItems.length === 1) {
        setShowRemoveButton(false);
      }
    }
  };

  return (
    <Modal show={open} onHide={resetFormAndCloseModal} aria-labelledby="ModalHeader" centered>
      <Modal.Header closeButton>
        <Modal.Title id='ModalHeader'><h2>Add Project</h2></Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formProjectName" style={{ marginBottom: '15px' }}>
            <Form.Control
              type="text"
              placeholder="Project Name"
              name="projectName"
              value={formData.projectName}
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

          <Form.Group controlId="formSupplierName" style={{ marginBottom: '15px' }}>
            <Form.Control
              type="text"
              placeholder="Supplier Name"
              name="supplierName"
              value={formData.supplierName}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>

          {formData.orderItems.map((item, index) => (
            <div key={index}>
              <Form.Group controlId={`formProductName${index}`} style={{ marginBottom: '15px' }}>
                <Form.Control
                  type="text"
                  placeholder={`Product Name ${index + 1}`}
                  name="productName"
                  value={item.productName}
                  onChange={(e) => handleInputChange(e, index)}
                  style={{ width: '100%' }}
                />
              </Form.Group>

              <Form.Group controlId={`formQuantity${index}`} style={{ marginBottom: '15px' }}>
                <Form.Control
                  type="number"
                  placeholder="Quantity"
                  name="quantity"
                  min="1"
                  value={item.quantity}
                  onChange={(e) => handleInputChange(e, index)}
                  style={{ width: '100%' }}
                />
              </Form.Group>
            </div>
          ))}
          {showRemoveButton && (
            <Button variant="danger" onClick={removeLastOrderItem} style={{ marginBottom: '15px' }}>
              Remove Last Product
            </Button>
          )}
          <Button variant="secondary" onClick={addOrderItem}>Add Product</Button>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant='secondary' onClick={resetFormAndCloseModal}>
          Cancel
        </Button>
        <Button variant='primary' onClick={handleSave}>
          Save
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default AddProjectModal;
