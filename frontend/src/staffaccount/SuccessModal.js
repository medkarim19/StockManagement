import React, { useState, useEffect } from 'react';

const SuccessModal = ({ open, closeModal, userEmail }) => {
  const [isOpen, setIsOpen] = useState(open);

  useEffect(() => {
    setIsOpen(open);

    if (open) {
      const timeout = setTimeout(() => {
        setIsOpen(false);
        if (typeof closeModal === 'function') {
          closeModal(); 
        }
      }, 8000); 

      return () => clearTimeout(timeout);
    }
  }, [open, closeModal]); 

  const handleClose = () => {
    setIsOpen(false);
    if (typeof closeModal === 'function') {
      closeModal(); 
    }
  };

  const successStyle = {
    position: 'fixed',
    top: '10px',
    left: '50%',
    transform: 'translateX(-50%)',
    padding: '20px',
    borderRadius: '8px',
    minWidth: '60%',
    maxWidth: '60%',
    display: isOpen ? 'block' : 'none',
    zIndex: '1000',
    textAlign: 'center',
  };

  return (
    <div className="alert alert-success alert-dismissible fade show" role="alert" style={successStyle}>
      <span className="alert-icon"><i className="ni ni-like-2"></i></span>
      <span className="alert-text"><strong>Success!</strong> Congratulations, the user with email {userEmail} is now a Super User!</span>
      <button type="button" className="close" data-dismiss="alert" aria-label="Close" onClick={handleClose}>
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
  );
};

export default SuccessModal;
