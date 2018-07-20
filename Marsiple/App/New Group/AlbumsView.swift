//
//  AlbumsView.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class AlbumsView: UIView {
    private var albums = [Album]()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        cell.updateCell(withAlbum: albums[indexPath.row])
        return cell
    }
}

extension AlbumsView {
    func updateData(withAlbums albums: [Album]) {
        self.albums = albums
        tableView.reloadData()
    }
}

private extension AlbumsView {
    func setupViews() {
        setupTableView()
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
