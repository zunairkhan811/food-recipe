document.addEventListener("DOMContentLoaded", function() {
    const switchInput = document.querySelector('.form-check-input');
  
    switchInput.addEventListener('change', function() {
      const isChecked = this.checked;
      const status = isChecked ? 1 : 0;
  
      const recipeId = this.dataset.recipeId;
  
      // Make an AJAX request to update the status in your controller
      fetch(`/recipes/${recipeId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ public: status })
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          // Update the label text based on the new public status
          const label = document.querySelector('.form-check-label');
          label.textContent = isChecked ? 'Public' : 'Private';
  
          console.log('Update successful', data.message);
        } else {
          // If the update fails, revert the checkbox state
          this.checked = !isChecked;
          console.error('Error updating status:', data.errors);
        }
      })
      .catch(error => {
        // If there's an error, revert the checkbox state
        this.checked = !isChecked;
        console.error('Error updating status:', error);
      });
    });
  });
  