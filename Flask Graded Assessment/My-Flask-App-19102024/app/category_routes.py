from flask import Blueprint, render_template, redirect, request

category_routes = Blueprint('category_routes', __name__)

categories = []

@category_routes.route('/category')
def index():
    return render_template('/category/index.html', title='Categories', categories=categories)

@category_routes.route('/category/create', methods=['GET', 'POST'])
def create():
    if request.method == 'POST':
        category = {
            'id': request.form['id'],
            'name': request.form['name'],
            'description': request.form['description']
        }
        categories.append(category)
        return redirect('/category')
    return render_template('/category/create.html', title='Create Category')

@category_routes.route('/category/update/<int:category_id>', methods=['GET', 'POST'])
def update(category_id):
    if request.method == 'POST':
        updated_category = {
            'id': request.form['id'],
            'name': request.form['name'],
            'description': request.form['description']
        }
        if updated_category:
            categories[category_id-1] = updated_category
            return redirect('/category')
    return render_template('/category/update.html', category=categories[category_id-1], category_id=category_id)

@category_routes.route('/category/delete/<int:category_id>')
def delete(category_id):
    categories.pop(category_id-1)
    return redirect('/category')